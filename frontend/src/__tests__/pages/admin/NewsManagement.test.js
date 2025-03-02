import React from 'react';
import { render, screen, fireEvent, waitFor, within } from '@testing-library/react';
import NewsManagement from '../../../component/pages/admin/NewsManagement';
import axios from '../../../config/axiosConfig';

// Mocks
jest.mock('../../../component/pages/admin/components/AdminSidebar', () => 
  jest.fn(() => <div data-testid="mock-sidebar" />)
);
jest.mock('../../../config/axiosConfig', () => ({
  get: jest.fn(),
  post: jest.fn(),
  delete: jest.fn()
}));

describe('NewsManagement', () => {
  const mockNews = [
    {
      id: 1,
      title: 'Test News 1',
      description: 'Description 1',
      category: 'Festival',
      importance: 'Haute'
    },
    {
      id: 2,
      title: 'Test News 2',
      description: 'Description 2',
      category: 'Artiste',
      importance: 'Moyenne'
    }
  ];

  beforeEach(() => {
    jest.clearAllMocks();
    axios.get.mockResolvedValue({ data: mockNews });
  });

  test('renders loading message initially', () => {
    render(<NewsManagement />);
    // Vérifier la présence du spinner par sa classe CSS
    const spinner = document.querySelector('.animate-spin');
    expect(spinner).toBeInTheDocument();
  });

  test('renders news list after loading', async () => {
    // Mise à jour du mockNews avec des valeurs numériques pour "importance"
    const mockNews = [
      {
        id: 1,
        title: 'Test News 1',
        description: 'Description 1',
        category: 'Festival',
        importance: 2  // 2 correspond à "Haute"
      },
      {
        id: 2,
        title: 'Test News 2',
        description: 'Description 2',
        category: 'Artiste',
        importance: 1  // 1 correspond à "Moyenne"
      }
    ];
  
    // On simule l'appel API avec ce nouveau mockNews
    axios.get.mockResolvedValue({ data: mockNews });
    
    render(<NewsManagement />);
    
    await waitFor(() => {
      expect(screen.getByText('Gestion des Actualités')).toBeInTheDocument();
    });
    
    expect(screen.getByText('Test News 1')).toBeInTheDocument();
    expect(screen.getByText('Test News 2')).toBeInTheDocument();
    expect(screen.getByText('Festival')).toBeInTheDocument();
    expect(screen.getByText('Artiste')).toBeInTheDocument();
    expect(screen.getByText('Haute')).toBeInTheDocument();
    expect(screen.getByText('Moyenne')).toBeInTheDocument();
  });
  

  test('shows add news form when button is clicked', async () => {
    render(<NewsManagement />);
    
    await waitFor(() => {
      expect(screen.getByText('Ajouter une Actualité')).toBeInTheDocument();
    });
    
    fireEvent.click(screen.getByText('Ajouter une Actualité'));
    
    // Utilise l'input titre comme ancre pour restreindre la recherche au formulaire
    const titleInput = screen.getByPlaceholderText("Titre de l'actualité");
    expect(titleInput).toBeInTheDocument();
    const formContainer = titleInput.closest('form');
    expect(formContainer).toBeInTheDocument();
    
    // Rechercher les autres éléments à l'intérieur du formulaire
    expect(within(formContainer).getByPlaceholderText("Description de l'actualité")).toBeInTheDocument();
    expect(within(formContainer).getByText('Catégorie')).toBeInTheDocument();
    expect(within(formContainer).getByText('Importance')).toBeInTheDocument();
  });

  test('adds a new news item', async () => {
    axios.post.mockResolvedValue({ 
      data: { 
        id: 3, 
        title: 'New News', 
        category: 'Festival',
        importance: 2  // Valeur numérique pour "Haute"
      } 
    });
    
    render(<NewsManagement />);
    
    await waitFor(() => {
      expect(screen.getByText('Ajouter une Actualité')).toBeInTheDocument();
    });
    
    fireEvent.click(screen.getByText('Ajouter une Actualité'));
    
    // Remplit le formulaire
    fireEvent.change(screen.getByPlaceholderText("Titre de l'actualité"), {
      target: { value: 'New News' }
    });
    fireEvent.change(screen.getByPlaceholderText("Description de l'actualité"), {
      target: { value: 'New Description' }
    });
    
    // Suppose que les selects sont affichés dans le formulaire (ordre: catégorie, importance)
    const formSelects = within(screen.getByPlaceholderText("Titre de l'actualité").closest('form')).getAllByRole('combobox');
    fireEvent.change(formSelects[0], { target: { value: 'Festival' } });
    // On passe la valeur "2" pour représenter "Haute"
    fireEvent.change(formSelects[1], { target: { value: '2' } });
    
    fireEvent.click(screen.getByText('Enregistrer'));
    
    await waitFor(() => {
      expect(axios.post).toHaveBeenCalledWith('/api/admin/news', expect.objectContaining({
        title: 'New News',
        category: 'Festival',
        importance: 2
      }));
    });
  });
  

  test('deletes a news item', async () => {
    // S'assurer que window.confirm renvoie true
    window.confirm = jest.fn(() => true);
    
    // Simuler une réponse réussie de l'API pour le chargement initial
    axios.get.mockResolvedValue({
      data: [
        { id: 1, title: 'Test News 1', category: 'Festival', importance: 'Haute' },
        { id: 2, title: 'Test News 2', category: 'Artiste', importance: 'Moyenne' }
      ]
    });
    
    // Simuler une réponse réussie pour la suppression
    axios.delete.mockResolvedValue({});
    
    render(<NewsManagement />);
    
    // Attendre que le contenu soit chargé
    await waitFor(() => {
      expect(screen.getByText('Test News 1')).toBeInTheDocument();
    });
    
    // Cliquer sur le premier bouton de suppression
    const deleteButtons = screen.getAllByText('Supprimer');
    fireEvent.click(deleteButtons[0]);
    
    // Vérifier que la confirmation a été demandée
    expect(window.confirm).toHaveBeenCalled();
    
    // Vérifier que axios.delete a été appelé avec la bonne URL
    await waitFor(() => {
      expect(axios.delete).toHaveBeenCalledWith('/api/admin/news/1');
    });
  });

  test('shows error message when API call fails', async () => {
    axios.get.mockRejectedValueOnce(new Error('API Error'));
    
    render(<NewsManagement />);
    
    await waitFor(() => {
      expect(screen.getByText('Erreur lors du chargement des actualités')).toBeInTheDocument();
    });
  });

  test('cancels form when cancel button is clicked', async () => {
    render(<NewsManagement />);
    
    await waitFor(() => {
      expect(screen.getByText('Ajouter une Actualité')).toBeInTheDocument();
    });
    
    fireEvent.click(screen.getByText('Ajouter une Actualité'));
    
    expect(screen.getByPlaceholderText("Titre de l'actualité")).toBeInTheDocument();
    
    fireEvent.click(screen.getByText('Annuler'));
    
    expect(screen.queryByPlaceholderText("Titre de l'actualité")).not.toBeInTheDocument();
    expect(screen.getByText('Ajouter une Actualité')).toBeInTheDocument();
  });
});
