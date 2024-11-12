// lib/screens/car_form_screen.dart
import 'package:flutter/material.dart';
import '../models/car.dart'; // Importa a classe Car
import '../services/api_service.dart'; // Importa o serviço ApiService

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
    _modelController = TextEditingController(text: widget.car?.model ?? '');
    _brandController = TextEditingController(text: widget.car?.brand ?? '');
    _yearController = TextEditingController(
        text: widget.car != null ? widget.car!.year.toString() : '');
    _priceController = TextEditingController(
        text: widget.car != null ? widget.car!.price.toString() : '');
    _quantityController = TextEditingController(
        text: widget.car != null ? widget.car!.quantity.toString() : '');
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

  Future<void> _saveCar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final car = Car(
        id: widget.car?.id, // mantém o ID para update
        model: _modelController.text,
        brand: _brandController.text,
        year: int.tryParse(_yearController.text) ?? 0,
        price: double.tryParse(_priceController.text) ?? 0.0,
        quantity: int.tryParse(_quantityController.text) ?? 0,
      );

      if (widget.car == null) {
        // Cria um novo carro se não existir
        await _apiService.createCar(car);
      } else {
        // Atualiza o carro existente
        await _apiService.updateCar(car);
      }

      // Volta para a tela anterior após salvar
      Navigator.pop(context, true);
    }
  }

  Future<void> _deleteCar() async {
    if (widget.car != null && widget.car!.id != null) {
      await _apiService.deleteCar(widget.car!.id!);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Carro'),
        actions: [
          if (widget.car != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar Exclusão'),
                    content: const Text('Deseja excluir este carro?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Excluir'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _deleteCar();
                }
              },
            ),
        ],
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
                  onPressed: _saveCar,
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
