class Dishes {
  final String id;
  final String title;
  final String image;

  Dishes({required this.id, required this.title, required this.image});


  factory Dishes.fromJson(Map<String, dynamic> json) {
    return Dishes(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
    );
  }
}
