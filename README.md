# Favourite Songs App

A full-stack web application that allows users to browse, vote on, and view album covers for their favourite songs. The frontend is built with **React**, and the backend is powered by **Node.js**, **Express**, and **PostgreSQL**.

---

## Features

### 🔹 Frontend (React)
- Responsive interface built with `create-react-app`
- Landing page and main app components (`LandingPage.js`, `MainApp.js`)
- CSS module-based styling (`App.css`, `LandingPage.css`)
- Testing setup with Jest and React Testing Library
- Web Vitals reporting via `reportWebVitals.js`

### 🔹 Backend (Express + PostgreSQL)
- REST API for:
  - Fetching songs
  - Fetching album cover images
  - Upvoting/downvoting songs per user
- Secure and validated endpoints
- Graceful error handling
- Test suite using Jest + Supertest

---

## 📁 Project Structure

```
favourite-songs-app/
├── client/                      # React frontend
│   ├── src/
│   │   ├── App.js
│   │   ├── LandingPage.js
│   │   ├── MainApp.js
│   │   ├── index.js
│   │   ├── *.css
│   │   └── *.test.js
│   ├── public/
│   └── package.json
│
├── server.js                    # Express backend
├── server.test.js               # Backend test suite
├── db.js                        # PostgreSQL connection
├── .env                         # Environment config
└── package.json                 # Root config and dependencies
```

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Damo89/favourite-songs-app.git
cd favourite-songs-app
```

### 2. Set up environment variables

Create a `.env` file in the root directory with:

```env
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/favorite_songs
PORT=5000
```

### 3. Install dependencies

#### Backend
```bash
npm install
```

#### Frontend
```bash
cd client
npm install
```

---

## ▶️ Running the App

### Start the backend:
```bash
npm start
```

### Start the frontend (in a separate terminal):
```bash
cd client
npm start
```

- Frontend runs on [http://localhost:3000](http://localhost:3000)
- Backend API available at [http://localhost:5000](http://localhost:5000)

---

## 🧪 Running Tests

### Backend tests:
```bash
npm test
```

### Frontend tests:
```bash
cd client
npm test
```

---

## 🌐 API Endpoints

### `GET /songs`
Returns a list of all songs.

### `GET /album-covers`
Returns an array of album image URLs.

### `POST /songs/:id/vote`
Upvotes or downvotes a song.

**Request body:**
```json
{
  "direction": 1,
  "userId": "user123"
}
```

**Direction**: `1` for upvote, `-1` for downvote.

---

## 🧠 Future Improvements

- Add authentication (OAuth or JWT)
- Frontend: Show current vote counts, user history
- Dockerize for deployment
- Use Redux or React Context for state management

---

## 🪪 License

MIT © Damien
