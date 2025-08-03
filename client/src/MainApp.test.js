import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import axios from 'axios';
import MainApp from './MainApp';

jest.mock('axios');

const mockSongs = [
  {
    id: 100,
    title: 'Song A',
    artist: 'Artist A',
    album: 'Album A',
    year_of_release: 2010,
    description: 'Description A',
    album_image_url: 'https://via.placeholder.com/300',
    youtube_link: 'https://www.youtube.com/watch?v=test1',
    votes: 10,
  },
  {
    id: 90,
    title: 'Top 10 Song',
    artist: 'Top Artist',
    album: 'Top Album',
    year_of_release: 2022,
    description: 'This is one of my top 10 songs.',
    album_image_url: 'https://via.placeholder.com/300',
    youtube_link: 'https://www.youtube.com/watch?v=top10',
    votes: 99,
  }
];

describe('MainApp', () => {
  beforeEach(() => {
    axios.get.mockResolvedValue({ data: mockSongs });
    localStorage.clear();
  });

  it('renders song data', async () => {
    render(
      <MemoryRouter>
        <MainApp />
      </MemoryRouter>
    );

    await waitFor(() => {
      expect(screen.getByText(/Song A/i)).toBeInTheDocument();
      expect(screen.getByText(/Artist A/i)).toBeInTheDocument();
      expect(screen.getByText(/2010/i)).toBeInTheDocument();
    });
  });

  it('renders song data and handles Top 10 nav button click', async () => {
    render(
      <MemoryRouter>
        <MainApp />
      </MemoryRouter>
    );

    // Wait for the first song to appear
    await waitFor(() => {
      expect(screen.getByText(/Song A/i)).toBeInTheDocument();
      expect(screen.getByText(/Artist A/i)).toBeInTheDocument();
      expect(screen.getByText(/2010/i)).toBeInTheDocument();
    });

    // Click "Top 10" button (just to confirm it's clickable)
    const top10Buttons = screen.getAllByText(/Top 10/i);
    fireEvent.click(top10Buttons[0]);

    // Confirm the original song is still there
    expect(screen.getByText(/Song A/i)).toBeInTheDocument();
  });

  it('renders all section navigation buttons', () => {
    render(<MemoryRouter><MainApp /></MemoryRouter>);
    expect(screen.getAllByText('100–76')).toHaveLength(2); // nav bar and drawer
    expect(screen.getAllByText('Top 10')).toHaveLength(2);
  });

  it('displays first song details from mocked data', async () => {
    render(<MemoryRouter><MainApp /></MemoryRouter>);
    await waitFor(() => {
      expect(screen.getByText(/Song A/i)).toBeInTheDocument();
      expect(screen.getByText(/Artist A/i)).toBeInTheDocument();
      expect(screen.getByText(/2010/i)).toBeInTheDocument();
      expect(screen.getByText(/Description A/i)).toBeInTheDocument();
    });
  });

  it('Next and Previous navigation buttons render and respond', async () => {
    render(<MemoryRouter><MainApp /></MemoryRouter>);
    await screen.findByText(/Song A/i); // wait for data

    const nextButtons = screen.getAllByRole('button', { name: /Next/i });
    const prevButtons = screen.getAllByRole('button', { name: /Previous/i });

    fireEvent.click(nextButtons[nextButtons.length - 1]);
    fireEvent.click(prevButtons[prevButtons.length - 1]);

    expect(screen.getByText(/Song A/i)).toBeInTheDocument();
  });

  it('renders YouTube video iframe for song', async () => {
    render(<MemoryRouter><MainApp /></MemoryRouter>);
    const iframe = await screen.findByTitle(/Song A/i);
    expect(iframe).toBeInTheDocument();
  });

  it('renders vote buttons and vote count', async () => {
    render(<MemoryRouter><MainApp /></MemoryRouter>);
    await screen.findByText(/Song A/i);

    expect(screen.getByLabelText(/Upvote/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/Downvote/i)).toBeInTheDocument();
    expect(screen.getByText('10')).toBeInTheDocument(); // vote count
  });

  it('matches snapshot', async () => {
    const { asFragment } = render(<MemoryRouter><MainApp /></MemoryRouter>);
    await screen.findByText(/Song A/i);
    expect(asFragment()).toMatchSnapshot();
  });
});
