class Car {
  final String? id;
  final String model;
  final String brand;
  final int year;
  final double price;
  final int quantity;
  final String? categoryId;

  Car({
    this.id,
    required this.model,
    required this.brand,
    required this.year,
    required this.price,
    required this.quantity,
    this.categoryId,
  });

 factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String?,  // Garantir que id seja tratado como String?
      model: json['model'] as String? ?? '',  // Se o model for null, usar uma string vazia
      brand: json['brand'] as String? ?? '',  // Se a marca for null, usar uma string vazia
      year: json['year'] as int? ?? 0,  // Se o ano for null, usar 0
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,  // Garantir que o preço seja um número válido
      quantity: json['quantity'] as int? ?? 0,  // Se a quantidade for null, usar 0
      categoryId: json['categoryId'] as String?,  // Categoria pode ser null
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
      'price': price,
      'quantity': quantity,
      'categoryId': categoryId,
    };
  }
}
