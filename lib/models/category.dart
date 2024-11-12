class Category {
  final String id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String? ??
          '', // Define um valor padrão se 'id' for null
      name: json['name'] as String? ??
          '', // Define um valor padrão se 'name' for null
      description: json['description'] as String? ??
          '', // Define um valor padrão se 'description' for null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
