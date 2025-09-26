import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/model/dish_model.dart';

class ApiServices {
  static String apiUrl =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=Chicken";

  static Future<List<Dishes>> fetchDishes() async {
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List dishesJson = data['meals']; // "meals" not "results"
      return dishesJson.map((json) => Dishes.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load dishes');
    }
  }
}
