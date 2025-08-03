const request = require('supertest');
const app = require('./server');

// Mock DB
jest.mock('./db', () => ({
  query: jest.fn(),
}));

const pool = require('./db');

beforeEach(() => {
  jest.clearAllMocks();
});

//
// TEST: GET /songs
//
describe('GET /songs', () => {
  it('should return a list of songs', async () => {
    pool.query.mockResolvedValue({
      rows: [{ id: 1, title: 'Test Song' }],
    });

    const res = await request(app).get('/songs');
    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual([{ id: 1, title: 'Test Song' }]);
  });

  it('should handle DB errors gracefully', async () => {
    pool.query.mockRejectedValue(new Error('DB failure'));

    const res = await request(app).get('/songs');
    expect(res.statusCode).toBe(500);
    expect(res.text).toBe('Server error');
  });
});

//
// TEST: GET /album-covers
//
describe('GET /album-covers', () => {
  it('should return an array of album_image_url strings', async () => {
    pool.query.mockResolvedValue({
      rows: [
        { album_image_url: 'https://img.com/1.jpg' },
        { album_image_url: 'https://img.com/2.jpg' },
      ],
    });

    const res = await request(app).get('/album-covers');
    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual([
      'https://img.com/1.jpg',
      'https://img.com/2.jpg',
    ]);
  });

  it('should handle DB errors gracefully', async () => {
    pool.query.mockRejectedValue(new Error('DB error'));

    const res = await request(app).get('/album-covers');
    expect(res.statusCode).toBe(500);
    expect(res.text).toBe('Server error');
  });
});

//
// TEST: POST /songs/:id/vote
//
describe('POST /songs/:id/vote', () => {
  const songId = 100;
  const userId = 'user123';

  it('should insert a new upvote and return updated vote count', async () => {
    pool.query
      .mockResolvedValueOnce({ rows: [] }) // no previous vote
      .mockResolvedValueOnce({})           // insert vote
      .mockResolvedValueOnce({})           // update total
      .mockResolvedValueOnce({ rows: [{ votes: 5 }] }); // get new vote total

    const res = await request(app)
      .post(`/songs/${songId}/vote`)
      .send({ direction: 1, userId });

    expect(res.statusCode).toBe(200);
    expect(res.body.votes).toBe(5);
  });

  it('should change an existing vote and return updated vote count', async () => {
    pool.query
      .mockResolvedValueOnce({ rows: [{ vote: 1 }] }) // previous vote
      .mockResolvedValueOnce({})                      // update vote
      .mockResolvedValueOnce({})                      // update total
      .mockResolvedValueOnce({ rows: [{ votes: 4 }] }); // get new vote total

    const res = await request(app)
      .post(`/songs/${songId}/vote`)
      .send({ direction: -1, userId });

    expect(res.statusCode).toBe(200);
    expect(res.body.votes).toBe(4);
  });

  it('should return null when no change in vote', async () => {
    pool.query.mockResolvedValueOnce({ rows: [{ vote: 1 }] }); // existing vote is same

    const res = await request(app)
      .post(`/songs/${songId}/vote`)
      .send({ direction: 1, userId });

    expect(res.statusCode).toBe(200);
    expect(res.body.votes).toBe(null);
  });

  it('should reject invalid vote directions', async () => {
    const res = await request(app)
      .post(`/songs/${songId}/vote`)
      .send({ direction: 7, userId });

    expect(res.statusCode).toBe(400);
    expect(res.body).toEqual({ error: 'Invalid vote direction' });
  });

  it('should handle DB errors gracefully', async () => {
    pool.query.mockRejectedValue(new Error('vote fail'));

    const res = await request(app)
      .post(`/songs/${songId}/vote`)
      .send({ direction: 1, userId });

    expect(res.statusCode).toBe(500);
    expect(res.body.error).toBe('Server error');
  });
});
