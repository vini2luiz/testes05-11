// car_list_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_estoque/models/car.dart';
import 'package:projeto_estoque/screens/car_form_screen.dart';
import 'package:projeto_estoque/services/api_service.dart';

class CarListScreen extends StatefulWidget {
  final List<Car> cars;

  const CarListScreen({Key? key, required this.cars}) : super(key: key);

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
      ),
      body: ListView.builder(
        itemCount: widget.cars.length,
        itemBuilder: (context, index) {
          final car = widget.cars[index];
          return ListTile(
            title: Text(car.model),
            subtitle: Text('${car.brand} - ${car.year}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarFormScreen(car: car),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirmar Exclusão'),
                        content: Text('Deseja realmente excluir este carro?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Excluir'),
                          ),
                        ],
                      ),
                    );

                    if (confirm) {
                      await _apiService.deleteCar(car.id!);
                      setState(() {
                        widget.cars.removeAt(index);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
