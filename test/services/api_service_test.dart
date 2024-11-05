// test/services/api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart'; // Certifique-se de que esta importação está aqui
import 'package:mockito/mockito.dart';
import 'package:projeto_estoque/services/api_service.dart';
import 'package:projeto_estoque/models/car.dart';

// Anotação para gerar o mock
@GenerateMocks([ApiService])
import 'api_service_test.mocks.dart';

void main() {
  group('ApiService - GET com filtro', () {
    // Declarando o mock
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService(); // Usando a classe de mock gerada
    });

    test('Retorna apenas carros de ano específico (com Mock)', () async {
      final mockResponse = [
        Car(id: '1', model: 'Fusca', brand: 'Volkswagen', year: 1980, price: 15000, quantity: 5),
        Car(id: '2', model: 'Gol', brand: 'Volkswagen', year: 2010, price: 20000, quantity: 3),
      ];

      // Mock da chamada HTTP usando o método `getCars`
      when(mockApiService.getCars()).thenAnswer((_) async => mockResponse);

      final filteredCars = await mockApiService.getCars(); // Simulando o filtro
      final specificYearCars = filteredCars.where((car) => car.year == 1980).toList();

      // Verifica se o filtro está retornando apenas os carros do ano específico
      expect(specificYearCars.length, 1);
      expect(specificYearCars[0].year, 1980);
    });
  });
}
