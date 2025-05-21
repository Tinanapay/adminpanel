class Item {
  String name;
  String description;

  Item({required this.name, required this.description});



  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? 'No Description',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

