import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { act } from 'react';
import ConcertManagement from '../../../component/pages/admin/ConcertManagement';
import axios from '../../../config/axiosConfig';

// Mocks des dépendances
jest.mock('../../../component/pages/admin/components/AdminSidebar', () =>
  jest.fn(() => <div data-testid="mock-sidebar" />)
);
jest.mock('../../../config/axiosConfig', () => ({
  get: jest.fn(),
  post: jest.fn(),
  put: jest.fn(),
  delete: jest.fn()
}));

describe('Gestion des Concerts', () => {
  // Données de concerts mockées
  const concertsMock = [
    {
      id: 1,
      name: 'Concert Rock Epic',
      description: 'Un concert de rock incroyable',
      image_url: 'rock.jpg',
      date: '2024-07-15T00:00:00.000Z',
      start_time: '19:00',
      end_time: '22:00',
      venue: 'Stade de Paris',
      type: 'Rock'
    },
    {
      id: 2,
      name: 'Festival Pop',
      description: 'Journée de musique pop',
      image_url: 'pop.jpg',
      date: '2024-08-16T00:00:00.000Z',
      start_time: '20:00',
      end_time: '23:00',
      venue: 'Zénith',
      type: 'Pop'
    }
  ];

  // Réinitialisation des mocks avant chaque test
  beforeEach(() => {
    jest.clearAllMocks();
    axios.get.mockResolvedValue({ data: concertsMock });
  });

  test('Affiche le spinner de chargement initial', async () => {
    // Garder la promesse non résolue pour conserver l'état de chargement
    axios.get.mockImplementationOnce(() => new Promise(() => {}));
    
    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Trouver le conteneur du spinner
    const spinnerContainer = screen.getByTestId('mock-sidebar').nextElementSibling;
    expect(spinnerContainer).toHaveClass('flex', 'items-center', 'justify-center');
    
    // Trouver le spinner lui-même en utilisant sa classe
    const spinner = spinnerContainer.querySelector('.animate-spin');
    expect(spinner).toBeInTheDocument();
    expect(spinner).toHaveClass('animate-spin');
  });

  test('Affiche la liste des concerts après chargement', async () => {
    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Attente et vérification du titre de la page
    await waitFor(() => {
      expect(screen.getByText('Gestion des Concerts')).toBeInTheDocument();
    });
    
    // Vérification de l'affichage des concerts
    expect(screen.getByText('Concert Rock Epic')).toBeInTheDocument();
    expect(screen.getByText('Festival Pop')).toBeInTheDocument();
    expect(screen.getByText('Rock')).toBeInTheDocument();
    expect(screen.getByText('Pop')).toBeInTheDocument();
  });

  test('Ouvre le formulaire d\'ajout de concert', async () => {
    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Attente et clic sur le bouton "Ajouter un Concert"
    await waitFor(() => {
      const boutonAjout = screen.getByText('Ajouter un Concert');
      expect(boutonAjout).toBeInTheDocument();
    });
    
    await act(async () => {
      fireEvent.click(screen.getByText('Ajouter un Concert'));
    });
    
    // Vérification des champs du formulaire
    await waitFor(() => {
      expect(screen.getByPlaceholderText('Nom du concert')).toBeInTheDocument();
      expect(screen.getByPlaceholderText('Lieu')).toBeInTheDocument();
      expect(screen.getByPlaceholderText('Description')).toBeInTheDocument();
      expect(screen.getByPlaceholderText('Type de concert')).toBeInTheDocument();
    });
  });

  test('Ajoute un nouveau concert', async () => {
    // Mock de la réponse de création de concert
    const nouveauConcert = {
      id: 3,
      name: 'Nouveau Concert Jazz',
      venue: 'Salle Pleyel',
      description: 'Soirée jazz exceptionnelle',
      type: 'Jazz'
    };
    axios.post.mockResolvedValue({ data: nouveauConcert });
    
    // Mock de la mise à jour de la liste des concerts
    axios.get
      .mockResolvedValueOnce({ data: concertsMock })
      .mockResolvedValueOnce({ data: [...concertsMock, nouveauConcert] });

    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Ouverture du formulaire d'ajout
    await waitFor(() => {
      const boutonAjout = screen.getByText('Ajouter un Concert');
      expect(boutonAjout).toBeInTheDocument();
    });
    
    await act(async () => {
      fireEvent.click(screen.getByText('Ajouter un Concert'));
    });
    
    // Remplissage du formulaire
    const nomInput = await screen.findByPlaceholderText('Nom du concert');
    const lieuInput = await screen.findByPlaceholderText('Lieu');
    const descriptionInput = await screen.findByPlaceholderText('Description');
    const typeInput = await screen.findByPlaceholderText('Type de concert');
    
    await act(async () => {
      fireEvent.change(nomInput, { target: { value: 'Nouveau Concert Jazz' } });
      fireEvent.change(lieuInput, { target: { value: 'Salle Pleyel' } });
      fireEvent.change(descriptionInput, { target: { value: 'Soirée jazz exceptionnelle' } });
      fireEvent.change(typeInput, { target: { value: 'Jazz' } });
    });
    
    // Soumission du formulaire
    await act(async () => {
      fireEvent.click(screen.getByText('Ajouter'));
    });
    
    // Vérifications
    await waitFor(() => {
      expect(axios.post).toHaveBeenCalledWith(
        '/api/admin/concerts',
        expect.objectContaining({
          name: 'Nouveau Concert Jazz',
          venue: 'Salle Pleyel',
          description: 'Soirée jazz exceptionnelle',
          type: 'Jazz'
        })
      );
      
      // Vérification du rechargement de la liste
      expect(axios.get).toHaveBeenCalledTimes(2);
    });
  });

  test('Modifie un concert existant', async () => {
    // Mock de la mise à jour du concert
    axios.put.mockResolvedValue({ 
      data: { 
        ...concertsMock[0], 
        name: 'Concert Rock Modifié' 
      } 
    });
    
    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Attente et ouverture du mode édition
    await waitFor(() => {
      const boutonsModifier = screen.getAllByText('Modifier');
      expect(boutonsModifier[0]).toBeInTheDocument();
    });
    
    await act(async () => {
      fireEvent.click(screen.getAllByText('Modifier')[0]);
    });
    
    // Vérification du pré-remplissage
    const nomInput = await screen.findByPlaceholderText('Nom du concert');
    expect(nomInput).toHaveValue('Concert Rock Epic');
    
    // Modification du nom
    await act(async () => {
      fireEvent.change(nomInput, { target: { value: 'Concert Rock Modifié' } });
    });
    
    // Soumission de la modification
    await act(async () => {
      fireEvent.click(screen.getAllByText('Modifier')[0]); // Utiliser le premier bouton Modifier
    });
    
    // Vérifications
    await waitFor(() => {
      expect(axios.put).toHaveBeenCalledWith(
        '/api/admin/concerts/1',
        expect.objectContaining({
          name: 'Concert Rock Modifié'
        })
      );
    });
  });

  test('Supprime un concert avec confirmation', async () => {
    // Mock de la confirmation de suppression
    const mockConfirm = jest.fn(() => true);
    window.confirm = mockConfirm;
    
    // Mock de la suppression et du rechargement
    axios.delete.mockResolvedValue({});
    axios.get
      .mockResolvedValueOnce({ data: concertsMock })
      .mockResolvedValueOnce({ data: [concertsMock[1]] });
  
    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Attente et déclenchement de la suppression
    await waitFor(() => {
      const boutonsSuppression = screen.getAllByText('Supprimer');
      expect(boutonsSuppression[0]).toBeInTheDocument();
    });
    
    await act(async () => {
      fireEvent.click(screen.getAllByText('Supprimer')[0]);
    });
    
    // Vérifications
    await waitFor(() => {
      expect(mockConfirm).toHaveBeenCalled();
      expect(axios.delete).toHaveBeenCalledWith('/api/admin/concerts/1'); // Correspond à l'URL réelle
      expect(axios.get).toHaveBeenCalledTimes(2);
    });
  });

  test('Gère l\'erreur de chargement des concerts', async () => {
    // Simulation d'une erreur lors du chargement
    axios.get.mockRejectedValueOnce(new Error('Erreur de réseau'));

    await act(async () => {
      render(<ConcertManagement />);
    });
    
    // Vérification du message d'erreur
    await waitFor(() => {
      expect(screen.getByText('Erreur lors du chargement des concerts')).toBeInTheDocument();
    });
  });
});