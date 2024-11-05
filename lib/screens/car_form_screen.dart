// lib/screens/car_form_screen.dart
import 'package:flutter/material.dart';
import '../models/car.dart';  // Importa a classe Car
import '../services/api_service.dart';  // Importa o serviço ApiService

class CarFormScreen extends StatefulWidget {
  final Car? car;

  const CarFormScreen({Key? key, this.car}) : super(key: key);

  @override
  State<CarFormScreen> createState() => _CarFormScreenState();
}

class _CarFormScreenState extends State<CarFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService(); // Instância do ApiService
  
  late TextEditingController _modelController;
  late TextEditingController _brandController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.car?.model);
    _brandController = TextEditingController(text: widget.car?.brand);
    _yearController = TextEditingController(text: widget.car?.year.toString());
    _priceController = TextEditingController(text: widget.car?.price.toString());
    _quantityController = TextEditingController(text: widget.car?.quantity.toString());
  }

  @override
  void dispose() {
    _modelController.dispose();
    _brandController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (int.tryParse(value) == null) {
      return 'Digite um número válido';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (double.tryParse(value) == null) {
      return 'Digite um valor válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: _validateNotEmpty,
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: _validateNotEmpty,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Ano'),
                validator: _validateNumber,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: _validatePrice,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: _validateNumber,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final car = Car(
                        model: _modelController.text,
                        brand: _brandController.text,
                        year: int.tryParse(_yearController.text) ?? 0,
                        price: double.tryParse(_priceController.text) ?? 0.0,
                        quantity: int.tryParse(_quantityController.text) ?? 0,
                      );

                      // Chama o método para salvar o carro via API
                      _apiService.saveCar(car);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
