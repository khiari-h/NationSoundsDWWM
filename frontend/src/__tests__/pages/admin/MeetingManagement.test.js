import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { act } from 'react';
import MeetingManagement from '../../../component/pages/admin/MeetingManagement';
import axios from '../../../config/axiosConfig';

// Mocks
jest.mock('../../../component/pages/admin/components/AdminSidebar', () => jest.fn(() => <div data-testid="mock-sidebar" />));
jest.mock('../../../config/axiosConfig', () => ({
  get: jest.fn(),
  post: jest.fn(),
  delete: jest.fn()
}));

describe('MeetingManagement', () => {
  const mockMeetings = [
    {
      id: 1,
      title: 'Meet & Greet with Artist 1',
      artist: { id: 1, name: 'Artist 1' },
      description: 'Description 1',
      date: '2023-07-15',
      start_time: '14:00',
      end_time: '16:00',
      venue: 'Backstage',
      type: 'Meet & Greet'
    },
    {
      id: 2,
      title: 'Workshop with Artist 2',
      artist: { id: 2, name: 'Artist 2' },
      description: 'Description 2',
      date: '2023-07-16',
      start_time: '10:00',
      end_time: '12:00',
      venue: 'Workshop Room',
      type: 'Workshop'
    }
  ];

  const mockArtists = [
    { id: 1, name: 'Artist 1' },
    { id: 2, name: 'Artist 2' },
    { id: 3, name: 'Artist 3' }
  ];

  beforeEach(() => {
    jest.clearAllMocks();
    // Mock the Promise.all for both API calls
    axios.get.mockImplementation((url) => {
      if (url === '/api/meetings') {
        return Promise.resolve({ data: mockMeetings });
      }
      if (url === '/api/artists') {
        return Promise.resolve({ data: mockArtists });
      }
      return Promise.reject(new Error('Not found'));
    });
  });

  test('renders loading message initially', async () => {
    // Suspendre la résolution des promesses pour garder l'état de chargement
    axios.get.mockImplementationOnce(() => new Promise(() => {}));
    
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    // Trouver le conteneur du spinner
    const spinnerContainer = screen.getByTestId('mock-sidebar').nextElementSibling;
    expect(spinnerContainer).toHaveClass('flex', 'items-center', 'justify-center');
    
    // Trouver le spinner lui-même en utilisant sa classe
    const spinner = spinnerContainer.querySelector('.animate-spin');
    expect(spinner).toBeInTheDocument();
    expect(spinner).toHaveClass('animate-spin');
  });

  test('renders meetings list after loading', async () => {
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    await waitFor(() => {
      expect(screen.getByText('Gestion des Rencontres Artistes')).toBeInTheDocument();
    });
    
    expect(screen.getByText('Meet & Greet with Artist 1')).toBeInTheDocument();
    expect(screen.getByText('Workshop with Artist 2')).toBeInTheDocument();
    expect(screen.getByText('Artist 1')).toBeInTheDocument();
    expect(screen.getByText('Artist 2')).toBeInTheDocument();
  });

  test('shows add meeting form when button is clicked', async () => {
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    await waitFor(() => {
      expect(screen.getByText('Ajouter une Rencontre')).toBeInTheDocument();
    });
    
    await act(async () => {
      fireEvent.click(screen.getByText('Ajouter une Rencontre'));
    });
    
    expect(screen.getByText('Sélectionner un artiste')).toBeInTheDocument();
    expect(screen.getByPlaceholderText('Titre de la rencontre')).toBeInTheDocument();
    expect(screen.getByPlaceholderText('Lieu')).toBeInTheDocument();
    expect(screen.getByText('Type de rencontre')).toBeInTheDocument();
  });

  test('adds a new meeting', async () => {
    axios.post.mockResolvedValue({ 
      data: { 
        id: 3, 
        title: 'New Meeting', 
        artist: { id: 1, name: 'Artist 1' },
        date: '2023-07-20'
      } 
    });
    
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    await waitFor(() => {
      expect(screen.getByText('Ajouter une Rencontre')).toBeInTheDocument();
    });
    
    // Clique sur le bouton pour afficher le formulaire d'ajout
    await act(async () => {
      fireEvent.click(screen.getByText('Ajouter une Rencontre'));
    });
    
    // Remplit le formulaire
    await act(async () => {
      fireEvent.change(screen.getByPlaceholderText("Titre de la rencontre"), {
        target: { value: 'New Meeting' }
      });
      
      fireEvent.change(screen.getByPlaceholderText('Lieu'), {
        target: { value: 'New Venue' }
      });
      
      fireEvent.change(screen.getByPlaceholderText('Description'), {
        target: { value: 'New Description' }
      });
      
      // Sélection de l'artiste : on récupère le <select> en ciblant l'étiquette "Sélectionner un artiste"
      const artistLabel = screen.getByText('Sélectionner un artiste');
      const artistSelect = artistLabel.closest('select');
      fireEvent.change(artistSelect, { target: { value: '1' } });
      
      // Sélection du type de rencontre : on récupère le <select> en ciblant l'étiquette "Type de rencontre"
      const typeLabel = screen.getByText('Type de rencontre');
      const typeSelect = typeLabel.closest('select');
      fireEvent.change(typeSelect, { target: { value: 'Meet & Greet' } });
    });
    
    // Soumission du formulaire
    await act(async () => {
      fireEvent.click(screen.getByText('Enregistrer'));
    });
    
    await waitFor(() => {
      expect(axios.post).toHaveBeenCalledWith('/api/admin/meetings', expect.objectContaining({
        title: 'New Meeting',
        artist_id: '1'
      }));
    });
  });
  
  test('deletes a meeting', async () => {
    // Configuration des mocks
    window.confirm = jest.fn().mockReturnValue(true);
    
    // Important: assurez-vous que ces mocks fonctionnent correctement
    axios.get.mockImplementation((url) => {
      if (url === '/api/meetings') {
        return Promise.resolve({ data: mockMeetings });
      }
      if (url === '/api/artists') {
        return Promise.resolve({ data: mockArtists });
      }
      return Promise.reject(new Error('Not found'));
    });
    
    axios.delete.mockResolvedValue({ data: {} });
    
    // Rendu du composant
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    // Attendre que le composant finisse de charger et affiche les boutons
    await waitFor(() => {
      expect(screen.getAllByText('Supprimer').length).toBeGreaterThan(0);
    });
    
    // Simuler le clic sur le bouton de suppression
    await act(async () => {
      fireEvent.click(screen.getAllByText('Supprimer')[0]);
    });
    
    // Vérifier que window.confirm a été appelé
    expect(window.confirm).toHaveBeenCalled();
    
    // Debug pour voir ce qui se passe
    console.log('axios.delete mock calls:', axios.delete.mock.calls);
    
    // Vérifier que axios.delete a été appelé
    await waitFor(() => {
      expect(axios.delete).toHaveBeenCalledWith('/api/admin/meetings/1');
    }, { timeout: 3000 });
  });

  test('shows error message when API call fails', async () => {
    axios.get.mockImplementation(() => Promise.reject(new Error('API Error')));
    
    await act(async () => {
      render(<MeetingManagement />);
    });
    
    await waitFor(() => {
      expect(screen.getByText('Erreur lors du chargement des données')).toBeInTheDocument();
    });
  });
});