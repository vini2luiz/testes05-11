// server.js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/storageDB')
  .then(() => console.log('Conectado ao MongoDB'))
  .catch(err => console.error('Erro ao conectar ao MongoDB:', err));

const categorySchema = new mongoose.Schema({
  name: { type: String, required: true }
});

const carSchema = new mongoose.Schema({
  name: { type: String, required: true },
  categoryId: { type: mongoose.Schema.Types.ObjectId, ref: 'Category', required: true }
});

const Category = mongoose.model('Category', categorySchema);
const Car = mongoose.model('Car', carSchema);

// Rota para listar categorias
app.get('/categories', async (req, res) => {
  try {
    const categories = await Category.find();
    res.json(categories);
  } catch (err) {
    res.status(500).send('Erro ao buscar categorias');
  }
});

// Rota para criar categoria
app.post('/categories', async (req, res) => {
  try {
    const category = new Category(req.body);
    await category.save();
    res.status(201).json(category);
  } catch (err) {
    res.status(400).send('Erro ao criar categoria');
  }
});

// Rota para atualizar categoria
app.put('/categories/:id', async (req, res) => {
  try {
    const category = await Category.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!category) {
      return res.status(404).send('Categoria não encontrada');
    }
    res.json(category);
  } catch (err) {
    res.status(400).send('Erro ao atualizar categoria');
  }
});

// Rota para excluir categoria
app.delete('/categories/:id', async (req, res) => {
  try {
    const category = await Category.findByIdAndDelete(req.params.id);
    if (!category) {
      return res.status(404).send('Categoria não encontrada');
    }
    res.status(204).send();
  } catch (err) {
    res.status(500).send('Erro ao excluir categoria');
  }
});

// Rota para listar carros
app.get('/cars', async (req, res) => {
  try {
    const cars = await Car.find().populate('categoryId');
    res.json(cars);
  } catch (err) {
    res.status(500).send('Erro ao buscar carros');
  }
});

// Rota para criar carro
app.post('/cars', async (req, res) => {
  try {
    const car = new Car(req.body);
    await car.save();
    res.status(201).json(car);
  } catch (err) {
    res.status(400).send('Erro ao criar carro');
  }
});

// Rota para atualizar carro
app.put('/cars/:id', async (req, res) => {
  try {
    const car = await Car.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!car) {
      return res.status(404).send('Carro não encontrado');
    }
    res.json(car);
  } catch (err) {
    res.status(400).send('Erro ao atualizar carro');
  }
});

// Rota para excluir carro
app.delete('/cars/:id', async (req, res) => {
  try {
    const car = await Car.findByIdAndDelete(req.params.id);
    if (!car) {
      return res.status(404).send('Carro não encontrado');
    }
    res.status(204).send();
  } catch (err) {
    res.status(500).send('Erro ao excluir carro');
  }
});

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
