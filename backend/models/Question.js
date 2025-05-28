const mongoose = require('mongoose');

const questionSchema = new mongoose.Schema({
  questao: String,
  resposta_correta: String,
  respostas_falsas: [String], // 4 itens obrigatórios
  area_conhecimento: {
    type: String,
    enum: ['E', 'L', 'B', 'H'], // Exatas, Linguagens, Biológicas, Humanas
  },
  nivel_dificuldade: {
    type: Number,
    min: 1,
    max: 3,
  }
});

module.exports = mongoose.model('Question', questionSchema);
