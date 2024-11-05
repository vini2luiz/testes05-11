// test/models/car_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_estoque/models/car.dart';

void main() {
  group('Testes Unitários - Modelo Car', () {
    late List<Car> cars;

    setUp(() {
      // Lista inicial de carros para os testes
      cars = [
        Car(id: '1', model: 'Fusca', brand: 'Volkswagen', year: 1980, price: 15000, quantity: 5),
        Car(id: '2', model: 'Gol', brand: 'Volkswagen', year: 2010, price: 20000, quantity: 3),
      ];
    });

    test('Adicionar um carro ao estoque', () {
      final car = Car(id: '3', model: 'Civic', brand: 'Honda', year: 2020, price: 80000, quantity: 2);
      cars.add(car);
      expect(cars.contains(car), true);
    });

    test('Remover um carro do estoque', () {
      final car = cars[0]; // Removendo o primeiro carro da lista
      cars.remove(car);
      expect(cars.contains(car), false);
    });
  });
}
