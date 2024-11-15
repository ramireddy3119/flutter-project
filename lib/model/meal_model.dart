class Meal {
  final String id;
  final String name;
  final String category;
  final String thumbnail;

  Meal({required this.id, required this.name, required this.category, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      thumbnail: json['strMealThumb'],
    );
  }
}
