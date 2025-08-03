import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { FaHome } from 'react-icons/fa';
import axios from 'axios';
import { v4 as uuidv4 } from 'uuid';
import './App.css';

const API_BASE = process.env.REACT_APP_API_BASE_URL;

function MainApp() {
  const [songs, setSongs] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isBackgroundDark, setIsBackgroundDark] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [votes, setVotes] = useState({});
  const [userId, setUserId] = useState(null);
  const [fadeClass, setFadeClass] = useState('fade-in');

  const changeSongWithFade = (newIndex) => {
    if (newIndex < 0 || newIndex >= songs.length) return;

    setFadeClass('fade-out');

    setTimeout(() => {
      setCurrentIndex(newIndex);
      setFadeClass('fade-in');
    }, 400); // must match CSS duration
  };

  useEffect(() => {
    let storedId = localStorage.getItem('userId');
    if (!storedId) {
      storedId = uuidv4();
      localStorage.setItem('userId', storedId);
    }
    setUserId(storedId);
  }, []);

  useEffect(() => {
    axios.get(`${API_BASE}/songs`)
      .then(res => {
        const sorted = [...res.data].sort((a, b) => b.id - a.id);
        setSongs(sorted);
        setCurrentIndex(0);
      })
      .catch(err => console.error('Error fetching songs:', err));
  }, []);

  useEffect(() => {
    const setVh = () => {
      document.documentElement.style.setProperty('--vh', `${window.innerHeight * 0.01}px`);
    };
    setVh();
    window.addEventListener('resize', setVh);
    return () => window.removeEventListener('resize', setVh);
  }, []);

  // Load saved votes from localStorage
  useEffect(() => {
    const storedVotes = JSON.parse(localStorage.getItem('votes')) || {};
    setVotes(storedVotes);
  }, []);

  // Save votes to localStorage whenever they change
  useEffect(() => {
    localStorage.setItem('votes', JSON.stringify(votes));
  }, [votes]);

  const getYouTubeEmbedURL = (url) => {
    const match = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)/);
    return match ? `https://www.youtube.com/embed/${match[1]}` : null;
  };

  const getSpotifySearchURL = (query) => {
    const encodedQuery = encodeURIComponent(query);
    return `https://open.spotify.com/search/${encodedQuery}`;
  };

  const getImageBrightness = (imageUrl, callback) => {
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.src = imageUrl;

    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = canvas.height = 10;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0, 10, 10);
      const imageData = ctx.getImageData(0, 0, 10, 10).data;

      let colorSum = 0;
      for (let i = 0; i < imageData.length; i += 4) {
        const r = imageData[i];
        const g = imageData[i + 1];
        const b = imageData[i + 2];
        const avg = (r + g + b) / 3;
        colorSum += avg;
      }

      const brightness = colorSum / (10 * 10);
      callback(brightness);
    };
  };

  useEffect(() => {
    if (songs.length > 0 && Object.keys(votes).length === 0) {
      const updatedVotes = {};
      songs.forEach(song => {
        updatedVotes[song.id] = {
          status: 0,
          score: song.votes || 0,
        };
      });
      setVotes(updatedVotes);
    }
  }, [songs, votes]);


  const currentSong = songs[currentIndex];

  useEffect(() => {
    if (currentSong?.album_image_url) {
      getImageBrightness(currentSong.album_image_url, (brightness) => {
        setIsBackgroundDark(brightness < 128);
      });
    }
  }, [currentSong]);

  useEffect(() => {
    if (songs.length > 0) {
      setFadeClass('fade-in');
    }
  }, [songs]);

  useEffect(() => {
    if (fadeClass === 'fade-in') {
      const timeout = setTimeout(() => {
        setFadeClass('');
      }, 800); // matches animation duration

      return () => clearTimeout(timeout);
    }
  }, [fadeClass]);

  const handleNavClick = (index) => {
    if (index === currentIndex) return;

    setFadeClass('fade-out');

    setTimeout(() => {
      setCurrentIndex(index);
      setFadeClass('fade-in');
      setMenuOpen(false);
    }, 400); // matches the CSS transition duration
  };


  // Per-song voting logic
  const voteStatus = votes[currentSong?.id]?.status || 0;
  const voteScore = votes[currentSong?.id]?.score !== undefined
    ? votes[currentSong?.id].score
    : currentSong?.votes || 0;

  const updateVote = async (songId, newStatus) => {
    if (!userId) return;

    const previousStatus = votes[songId]?.status || 0;
    const direction = newStatus === previousStatus ? 0 : newStatus;

    try {
      const res = await axios.post(`http://localhost:5000/songs/${songId}/vote`, {
        direction,
        userId
      });

      if (res.data.votes !== null) {
      setVotes({
        ...votes,
        [songId]: {
          status: direction,
          score: res.data.votes
        },
      });
    }
    } catch (err) {
      console.error('Vote failed:', err);
    }
  };

  const handleUpvote = () => {
    updateVote(currentSong.id, 1);
  };

  const handleDownvote = () => {
    updateVote(currentSong.id, -1);
  };

  return (
    <div>
      <header className="navbar">
        <div className="navbar-container">
          <Link to="/" className="home-icon-link" aria-label="Go to Landing Page">
            <FaHome />
          </Link>

          <div className="logo">My Favourite <span className="highlight">100</span> Songs Ever</div>

          <button className="burger" onClick={() => setMenuOpen(!menuOpen)} aria-label="Toggle menu">
            <span className="bar"></span>
            <span className="bar"></span>
            <span className="bar"></span>
          </button>

          <nav className="nav-links">
            <button onClick={() => handleNavClick(0)}>100–76</button>
            <button onClick={() => handleNavClick(25)}>75–51</button>
            <button onClick={() => handleNavClick(50)}>50–26</button>
            <button onClick={() => handleNavClick(75)}>25–11</button>
            <button onClick={() => handleNavClick(90)}>Top 10</button>
          </nav>

          <nav className={`nav-drawer ${menuOpen ? 'open' : ''}`}>
            <div className="drawer-header">
              My Favourite <span className="highlight">100</span> Songs Ever
            </div>
            <button onClick={() => handleNavClick(0)}>100–76</button>
            <button onClick={() => handleNavClick(25)}>75–51</button>
            <button onClick={() => handleNavClick(50)}>50–26</button>
            <button onClick={() => handleNavClick(75)}>25–11</button>
            <button onClick={() => handleNavClick(90)}>Top 10</button>
          </nav>
        </div>
      </header>

      <div className="container">
        {currentSong && (
          <div className="song-card">
            <div
              className="blurred-bg"
              style={{ backgroundImage: `url(${currentSong.album_image_url})` }}
            ></div>

            <div className="glass-overlay">
              <button
                onClick={() => changeSongWithFade(currentIndex - 1)}
                disabled={currentIndex === 0}
                className="nav-chevron-button nav-left"
                aria-label="Previous"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="chevron-icon" viewBox="0 0 24 24">
                  <polyline points="15 18 9 12 15 6" />
                </svg>
              </button>

              <button
                onClick={() => changeSongWithFade(currentIndex + 1)}
                disabled={currentIndex === songs.length - 1}
                className="nav-chevron-button nav-right"
                aria-label="Next"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="chevron-icon" viewBox="0 0 24 24">
                  <polyline points="9 6 15 12 9 18" />
                </svg>
              </button>

              <div className={`song-body ${fadeClass} ${isBackgroundDark ? 'light-text' : 'dark-text'}`}>
                <div className="song-header-group">
                  <div className="song-number">{currentSong.id}</div>
                  <h3 className="song-title">
                    <a
                      href={getSpotifySearchURL(`${currentSong.title} ${currentSong.artist}`)}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {currentSong.title}
                    </a>
                  </h3>
                </div>

                <div className="song-content">
                  <div className="vote-controls-wrapper">
                    <div className="vote-controls">
                      <button
                        className={`vote-button upvote ${voteStatus === 1 ? 'active' : ''}`}
                        onClick={handleUpvote}
                        aria-label="Upvote"
                      >
                        ▲
                      </button>
                      <span className="vote-score">{voteScore}</span>
                      <button
                        className={`vote-button downvote ${voteStatus === -1 ? 'active' : ''}`}
                        onClick={handleDownvote}
                        aria-label="Downvote"
                      >
                        ▼
                      </button>
                    </div>
                  </div>

                  <div className="song-info">
                    <p><strong>Artist:</strong>{' '}
                      <a
                        href={getSpotifySearchURL(currentSong.artist)}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        {currentSong.artist}
                      </a>
                    </p>
                    <p><strong>Album:</strong>{' '}
                      <a
                        href={getSpotifySearchURL(`${currentSong.album} ${currentSong.artist}`)}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        {currentSong.album}
                      </a>
                    </p>
                    <p><strong>Year:</strong> {currentSong.year_of_release}</p>
                    <p className="song-description">{currentSong.description}</p>
                  </div>

                  {getYouTubeEmbedURL(currentSong.youtube_link) && (
                    <div className="video-wrapper">
                      <iframe
                        loading="lazy"
                        src={getYouTubeEmbedURL(currentSong.youtube_link)}
                        title={currentSong.title}
                        frameBorder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowFullScreen
                      ></iframe>
                    </div>
                  )}

                  <div className="bottom-nav-buttons">
                    <button
                      onClick={() => changeSongWithFade(currentIndex - 1)}
                      disabled={currentIndex === 0}
                      className="nav-button"
                    >
                      Previous
                    </button>
                    <button
                      onClick={() => changeSongWithFade(currentIndex + 1)}
                      disabled={currentIndex === songs.length - 1}
                      className="nav-button"
                    >
                      Next
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default MainApp;
