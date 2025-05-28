const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');

router.get('/user-info', (req, res) => {
  const header = req.headers['authorization'];
  const token = header?.split(' ')[1];
  if (!token) return res.status(403).send('Token necessário');

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) return res.status(403).send('Token inválido');
    res.json(decoded);
  });
});

module.exports = router;
