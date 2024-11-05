import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/car_list_screen.dart';
import '../models/car.dart'; // Certifique-se de que a classe 'Car' está importada

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Controle de Estoque',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gerenciamento de Veículos',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Estoque de Carros'),
            onTap: () {
              // Criando uma lista de carros fictícia para passar para a tela de estoque de carros
              final List<Car> cars = [
                Car(id: '1', model: 'Fusca', brand: 'Volkswagen', year: 1980, price: 15000, quantity: 5),
                Car(id: '2', model: 'Gol', brand: 'Volkswagen', year: 2010, price: 20000, quantity: 3),
              ];

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CarListScreen(cars: cars), // Passando a lista de carros
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
