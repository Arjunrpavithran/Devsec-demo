const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    status: 'success',
    message: 'DevSecOps Pipeline App is up and running!',
    timestamp: new Date()
  });
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});