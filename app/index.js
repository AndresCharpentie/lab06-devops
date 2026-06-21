const express = require('express');

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hola Mundo DevOps');
});

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'API funcionando correctamente'
  });
});

if (require.main === module) {
  app.listen(port, () => {
    console.log(`Aplicación escuchando en puerto ${port}`);
  });
}

module.exports = app;
