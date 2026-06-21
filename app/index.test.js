const request = require('supertest');
const app = require('./index');

describe('API DevOps Dummy', () => {
  test('GET /health debe retornar 200 OK', async () => {
    const response = await request(app).get('/health');

    expect(response.statusCode).toBe(200);
    expect(response.body.status).toBe('ok');
  });

  test('GET / debe retornar Hola Mundo DevOps', async () => {
    const response = await request(app).get('/');

    expect(response.statusCode).toBe(200);
    expect(response.text).toContain('Hola Mundo DevOps');
  });
});
