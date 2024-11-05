// test/screens/car_list_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_estoque/screens/car_list_screen.dart';
import 'package:projeto_estoque/models/car.dart';

void main() {
  testWidgets('Exibe a lista de carros no CarListScreen', (WidgetTester tester) async {
    final cars = [
      Car(id: '1', model: 'Fusca', brand: 'Volkswagen', year: 1980, price: 15000, quantity: 5),
      Car(id: '2', model: 'Gol', brand: 'Volkswagen', year: 2010, price: 20000, quantity: 3),
    ];

    await tester.pumpWidget(MaterialApp(
      home: CarListScreen(cars: cars), // Ajuste conforme o construtor
    ));

    // Verifica se os carros foram carregados e exibidos
    expect(find.text('Fusca'), findsOneWidget);
    expect(find.text('Gol'), findsOneWidget);
  });
}
