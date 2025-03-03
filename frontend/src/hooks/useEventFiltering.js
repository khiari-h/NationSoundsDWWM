import { useState, useEffect, useMemo, useCallback } from 'react';
import axios from '../config/axiosConfig';
import { formatDate, formatTime } from '../utils/formatUtilis';

export const useEventFiltering = (apiEndpoint, initialConfig = {}) => {
  // Mappage des clés françaises aux clés originales - mémoïsé pour stabilité
  const filterMapping = useMemo(() => ({
    'nom': 'name',
    'date': 'date',
    'lieu': 'venue',
    'type': 'type'
  }), []);

  // Configuration par défaut
  const defaultConfig = useMemo(() => ({
    initialFilters: {},
    transformData: (data) => 
      data.map(item => ({
        ...item,
        // Transformation des données à la source
        date: formatDate(item.date),
        start_time: formatTime(item.start_time),
        end_time: formatTime(item.end_time)
      })),
    filterStrategy: (event, filters) => 
      Object.entries(filters).every(([frKey, value]) => {
        const key = filterMapping[frKey] || frKey;
        if (!value) return true;
        
        // Gestion des comparaisons avec les valeurs transformées
        if (key === 'date' || key === 'start_time') {
          return event[key] === value;
        }
        
        if (key === 'name' || key === 'venue' || key === 'description') {
          return event[key]?.toLowerCase().includes(value.toLowerCase());
        }
        
        return event[key] === value;
      }),
    uniqueFilterKeys: []
  }), [filterMapping]);

  // Fusion mémoïsée de la configuration
  const config = useMemo(() => {
    // Convertir les clés françaises en clés originales pour la configuration interne
    const mappedInitialFilters = Object.keys(initialConfig.initialFilters || {}).reduce((acc, frKey) => {
      const originalKey = filterMapping[frKey] || frKey;
      acc[originalKey] = initialConfig.initialFilters[frKey];
      return acc;
    }, {});

    return {
      ...defaultConfig,
      ...initialConfig,
      initialFilters: mappedInitialFilters,
      uniqueFilterKeys: (initialConfig.uniqueFilterKeys || []).map(frKey => filterMapping[frKey] || frKey)
    };
  }, [defaultConfig, initialConfig, filterMapping]);

  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filters, setFilters] = useState(config.initialFilters);
  const [dataLoaded, setDataLoaded] = useState(false);

  const fetchEvents = useCallback(async () => {
    try {
      setLoading(true);
      const response = await axios.get(apiEndpoint);
      
      // Vérifier si la réponse contient des données
      if (!response.data) {
        throw new Error("La réponse ne contient pas de données");
      }
      
      // Appliquer la transformation des données
      const transformedData = config.transformData(response.data);
      setEvents(transformedData);
      setError(null);
      setDataLoaded(true);
    } catch (err) {
      console.error("Erreur lors de la récupération des données:", err);
      
      // Gestion détaillée des erreurs
      let errorMessage;
      
      if (err.response) {
        // La requête a été faite et le serveur a répondu avec un code d'état hors de la plage 2xx
        const statusCode = err.response.status;
        const serverMessage = err.response.data?.message || err.response.statusText || "Erreur serveur";
        
        if (statusCode === 404) {
          errorMessage = `Ressource introuvable: ${serverMessage}`;
        } else if (statusCode >= 500) {
          errorMessage = `Erreur serveur (${statusCode}): ${serverMessage}`;
        } else {
          errorMessage = `Erreur (${statusCode}): ${serverMessage}`;
        }
      } else if (err.request) {
        // La requête a été faite mais aucune réponse n'a été reçue
        errorMessage = "Aucune réponse du serveur. Vérifiez votre connexion réseau.";
      } else {
        // Une erreur s'est produite lors de la configuration de la requête
        errorMessage = err.message || "Erreur lors du chargement des données";
      }
      
      setError(errorMessage);
      setEvents([]);
    } finally {
      setLoading(false);
    }
  }, [apiEndpoint, config]);

  // Charger les données une seule fois au montage du composant
  useEffect(() => {
    if (!dataLoaded) {
      fetchEvents();
    }
  }, [fetchEvents, dataLoaded]);

  // Génération des valeurs uniques de filtres
  const uniqueFilterValues = useMemo(() => {
    const uniqueValues = {};
    // Utiliser les clés françaises pour la sortie
    const reverseMapping = Object.fromEntries(
      Object.entries(filterMapping).map(([fr, en]) => [en, fr])
    );

    config.uniqueFilterKeys.forEach(enKey => {
      const frKey = reverseMapping[enKey] || enKey;
      
      // Pour name et venue, extraire les valeurs uniques avec comparaison de chaîne
      let values = enKey === 'name' || enKey === 'venue'
        ? [...new Set(events.map(event => event[enKey]).filter(Boolean))]
        : [...new Set(events.map(event => event[enKey] || '').filter(Boolean))];
      
      if (enKey === 'date' || enKey === 'start_time') {
        values = values.sort();
      } else {
        values = values.sort((a, b) => a.localeCompare(b));
      }
      
      uniqueValues[frKey] = ['', ...values];
    });
    return uniqueValues;
  }, [events, config, filterMapping]);

  const filteredEvents = useMemo(() => 
    events.filter(event => config.filterStrategy(event, filters)),
    [events, filters, config]
  );

  const updateFilter = useCallback((key, value) => {
    setFilters(prev => ({ ...prev, [key]: value }));
  }, []);

  // Réinitialiser les filtres SANS recharger les données
  const resetFilters = useCallback(() => {
    setFilters(config.initialFilters);
  }, [config]);

  // Fonction explicite pour recharger les données
  const refetchData = useCallback(() => {
    setDataLoaded(false); // Force un nouveau chargement
    fetchEvents();
  }, [fetchEvents]);

  return {
    events: filteredEvents,
    loading,
    error,
    filters,
    updateFilter,
    resetFilters, 
    refetch: refetchData, 
    allEvents: events, 
    uniqueFilterValues
  };
};