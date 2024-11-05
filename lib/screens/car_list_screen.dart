import 'package:flutter/material.dart';
import 'package:projeto_estoque/models/car.dart';

class CarListScreen extends StatelessWidget {
  final List<Car> cars;

  CarListScreen({required this.cars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Carros'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return ListTile(
            title: Text(car.model),
            subtitle: Text('${car.brand} - ${car.year}'),
            trailing: Text('R\$${car.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
