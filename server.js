const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/storageDB', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log('Conectado ao MongoDB'))
  .catch(err => console.error('Erro ao conectar ao MongoDB:', err));

const categorySchema = new mongoose.Schema({
  name: { type: String, required: true }
});

const carschema = new mongoose.Schema({
  name: { type: String, required: true },
  categoryId: { type: mongoose.Schema.Types.ObjectId, ref: 'Category', required: true }
});

const Category = mongoose.model('Category', categorySchema);
const cars = mongoose.model('cars', carschema);

app.get('/categories', async (req, res) => {
  try {
    const categories = await Category.find();
    res.json(categories);
  } catch (err) {
    res.status(500).send('Erro ao buscar categorias');
  }
});

app.post('/categories', async (req, res) => {
  try {
    const category = new Category(req.body);
    await category.save();
    res.status(201).json(category);
  } catch (err) {
    res.status(400).send('Erro ao criar categoria');
  }
});

app.put('/categories/:id', async (req, res) => {
  console.log('Requisição PUT recebida para o ID:', req.params.id);
  console.log('Corpo da Requisição:', req.body);
  try {
    const category = await Category.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!category) {
      return res.status(404).send('Categoria não encontrada');
    }
    res.json(category);
  } catch (err) {
    console.error(err);
    res.status(400).send('Erro ao atualizar categoria');
  }
});

app.delete('/categories/:id', async (req, res) => {
  try {
    await Category.findByIdAndDelete(req.params.id);
    await cars.deleteMany({ categoryId: req.params.id });
    res.status(204).send();
  } catch (err) {
    res.status(400).send('Erro ao excluir categoria');
  }
});

app.get('/cars', async (req, res) => {
  try {
    const cars = await cars.find().populate('categoryId');
    res.json(cars);
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao buscar itens');
  }
});

app.post('/cars', async (req, res) => {
  try {
    const cars = new cars(req.body);
    await cars.save();
    res.status(201).json(cars);
  } catch (err) {
    res.status(400).send('Erro ao criar cars');
  }
});

app.put('/cars/:id', async (req, res) => {
  console.log('Requisição PUT recebida para o ID:', req.params.id);
  console.log('Corpo da Requisição:', req.body);
  try {
    const cars = await cars.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!cars) {
      return res.status(404).send('cars não encontrado');
    }
    res.json(cars);
  } catch (err) {
    console.error(err);
    res.status(400).send('Erro ao atualizar cars');
  }
});

app.delete('/cars/:id', async (req, res) => {
  try {
    await cars.findByIdAndDelete(req.params.id);
    res.status(204).send();
  } catch (err) {
    res.status(400).send('Erro ao excluir cars');
  }
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});