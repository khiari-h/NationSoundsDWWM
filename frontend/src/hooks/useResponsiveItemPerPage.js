import { useState, useEffect, useCallback, useMemo } from 'react';

export const useResponsiveItemsPerPage = (items = [], initialConfig = {}) => {
  // Mémoïser les configurations pour stabilité
  const defaultConfig = useMemo(() => ({
    mobile: 3,
    tablet: 4,
    desktop: 6
  }), []);

  // Mémoïser la configuration fusionnée
  const config = useMemo(() => ({
    ...defaultConfig,
    ...initialConfig
  }), [defaultConfig, initialConfig]);
  
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(config.desktop);

  // Extraire les valeurs spécifiques de config pour éviter
  // la dépendance à l'objet entier dans useCallback
  const { mobile, tablet, desktop } = useMemo(() => ({
    mobile: config.mobile,
    tablet: config.tablet,
    desktop: config.desktop
  }), [config.mobile, config.tablet, config.desktop]);

  const updateItemsPerPage = useCallback(() => {
    const width = window.innerWidth;

    if (width < 768) {
      setItemsPerPage(mobile);
    } else if (width < 1024) {
      setItemsPerPage(tablet);
    } else {
      setItemsPerPage(desktop);
    }
  }, [mobile, tablet, desktop]); // Dépendances primitives stables

  useEffect(() => {
    updateItemsPerPage();
    
    window.addEventListener('resize', updateItemsPerPage);
    return () => window.removeEventListener('resize', updateItemsPerPage);
  }, [updateItemsPerPage]);

  const paginatedItems = useMemo(() => {
    const start = (currentPage - 1) * itemsPerPage;
    return items.slice(start, start + itemsPerPage);
  }, [items, currentPage, itemsPerPage]);

  const totalPages = useMemo(() => 
    Math.ceil(items.length / itemsPerPage)
  , [items.length, itemsPerPage]);

  const pagination = useMemo(() => {
    if (totalPages <= 1) return null;

    return {
      currentPage,
      totalPages,
      setCurrentPage,
      hasPrevious: currentPage > 1,
      hasNext: currentPage < totalPages,
      onNext: () => setCurrentPage(page => Math.min(page + 1, totalPages)),
      onPrevious: () => setCurrentPage(page => Math.max(page - 1, 1)),
      onPageSelect: (page) => setCurrentPage(page)
    };
  }, [currentPage, totalPages]);

  return {
    itemsPerPage,
    currentPage,
    setCurrentPage,
    paginatedItems,
    totalPages,
    pagination
  };
};