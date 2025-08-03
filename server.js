const express = require('express');
const cors = require('cors');
const pool = require('./db');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Get all songs
app.get('/songs', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM favorite_songs ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// Get only album cover URLs
app.get('/album-covers', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT DISTINCT album_image_url FROM favorite_songs WHERE album_image_url IS NOT NULL'
    );
    const urls = result.rows.map(row => row.album_image_url);
    res.json(urls);
  } catch (err) {
    console.error('Error fetching album covers:', err.message);
    res.status(500).send('Server error');
  }
});

//POST vote for a song
app.post('/songs/:id/vote', async (req, res) => {
  const { id } = req.params;
  const { direction, userId } = req.body;

  if (![1, -1, 0].includes(direction)) {
    return res.status(400).json({ error: 'Invalid vote direction' });
  }

  try {
    const previous = await pool.query(
      'SELECT vote FROM song_votes WHERE user_id = $1 AND song_id = $2',
      [userId, id]
    );

    const prevVote = previous.rows[0]?.vote || 0;
    if (direction === 0 && prevVote === 0) {
      return res.json({ votes: null });
    }

    const voteChange = direction - prevVote;
    if (voteChange === 0) {
      return res.json({ votes: null });
    }

    await pool.query(
      `INSERT INTO song_votes (user_id, song_id, vote)
       VALUES ($1, $2, $3)
       ON CONFLICT (user_id, song_id)
       DO UPDATE SET vote = EXCLUDED.vote`,
      [userId, id, direction]
    );

    await pool.query(
      'UPDATE favorite_songs SET votes = votes + $1 WHERE id = $2',
      [voteChange, id]
    );

    const totalVotes = await pool.query(
      'SELECT votes FROM favorite_songs WHERE id = $1',
      [id]
    );

    res.json({ votes: totalVotes.rows[0].votes });
  } catch (err) {
    console.error('Vote error:', err.message);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = app;

if (require.main === module) {
  const PORT = process.env.PORT || 5000;
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}
