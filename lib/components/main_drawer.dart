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
                Car(id: '1', model: 'Civic', brand: 'Honda', year: 2018, price: 85000, quantity: 5),
                Car(id: '2', model: 'Gol', brand: 'Volkswagen', year: 2010, price: 20000, quantity: 3),
                Car(id: '3', model: 'Fusca', brand: 'Volkswagen', year: 1969, price: 15000, quantity: 2),
                Car(id: '4', model: 'Onix', brand: 'Chevrolet', year: 2020, price: 40000, quantity: 6),
                Car(id: '5', model: 'Fiesta', brand: 'Ford', year: 2014, price: 25000, quantity: 4),
                Car(id: '6', model: 'Argo', brand: 'Fiat', year: 2022, price: 55000, quantity: 3),
                Car(id: '7', model: 'Palio', brand: 'Fiat', year: 2016, price: 30000, quantity: 2),
                Car(id: '8', model: 'Kwid', brand: 'Renault', year: 2021, price: 45000, quantity: 7),
                Car(id: '9', model: 'HB20', brand: 'Hyundai', year: 2019, price: 35000, quantity: 5),
                Car(id: '10', model: 'Corolla', brand: 'Toyota', year: 2021, price: 120000, quantity: 4),

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
