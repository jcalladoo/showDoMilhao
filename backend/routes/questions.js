const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const Question = require('../models/Question');

function verifyToken(req, res, next) {
  const header = req.headers['authorization'];
  const token = header?.split(' ')[1];
  if (!token) return res.status(403).send('Token necessário');

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) return res.status(403).send('Token inválido');
    req.user = decoded;
    next();
  });
}

router.get('/', verifyToken, async (req, res) => {
  const questions = await Question.find();
  res.json(questions);
});

router.put('/:id', verifyToken, async (req, res) => {
  if (req.user.role !== 'professor') return res.status(403).send('Sem permissão');
  await Question.findByIdAndUpdate(req.params.id, req.body);
  res.sendStatus(200);
});

router.delete('/:id', verifyToken, async (req, res) => {
  if (req.user.role !== 'professor') return res.status(403).send('Sem permissão');
  await Question.findByIdAndDelete(req.params.id);
  res.sendStatus(200);
});

module.exports = router;