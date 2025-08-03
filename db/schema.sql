CREATE TABLE favorite_songs (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  artist TEXT NOT NULL,
  year_of_release INTEGER,
  album TEXT,
  description TEXT,
  youtube_link TEXT,
  album_image_url TEXT,
  votes INTEGER DEFAULT 0
);

CREATE TABLE song_votes (
  user_id TEXT NOT NULL,
  song_id INTEGER NOT NULL,
  vote INTEGER NOT NULL CHECK (vote = ANY (ARRAY[-1, 0, 1])),
  PRIMARY KEY (user_id, song_id),
  FOREIGN KEY (song_id) REFERENCES favorite_songs(id)
);