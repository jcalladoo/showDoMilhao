require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI;
console.log('MONGO_URI:', MONGO_URI);

// Conexão MongoDB
mongoose.connect(MONGO_URI)
  .then(() => console.log('✅ Conectado ao MongoDB'))
  .catch(err => console.error('❌ Erro MongoDB:', err));

mongoose.connection.on('connected', () => console.log('🟢 MongoDB conectado'));
mongoose.connection.on('error', err => console.log('🔴 MongoDB erro:', err));
mongoose.connection.on('disconnected', () => console.log('🟡 MongoDB desconectado'));

// Rotas
app.use('/login', require('./routes/login'));
app.use('/questions', require('./routes/questions'));
app.use('/', require('./routes/user'));

app.listen(PORT, () => {
  console.log(`🚀 Servidor rodando em http://localhost:${PORT}`);
});
