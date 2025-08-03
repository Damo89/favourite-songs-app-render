import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import './LandingPage.css';

const API_BASE = process.env.REACT_APP_API_BASE_URL;

function LandingPage() {
  const [albumImages, setAlbumImages] = useState([]);

  useEffect(() => {
    axios.get(`${API_BASE}/album-covers`)
      .then(res => setAlbumImages(res.data))
      .catch(err => console.error('Error loading album covers:', err));
  }, []);

  return (
    <div className="landing-container">
      <div className="album-collage">
        {albumImages.map((url, i) => (
          <img key={i} src={url} alt={`album-${i}`} className="collage-image" style={{ animationDelay: `${i * 20}ms` }} />
        ))}
        <div className="overlay"></div>
      </div>

      <div className="landing-content">
        <h1 className="landing-title">My Favourite <span className="highlight">100</span> Songs Ever</h1>
        <p className="landing-description">
          Dive into a handpicked journey through my top 100 songs. Discover iconic albums,
          relive timeless tracks, and open them on Spotify.
        </p>
        <Link to="/app" className="landing-button">View the List</Link>
      </div>
    </div>
  );
}

export default LandingPage;