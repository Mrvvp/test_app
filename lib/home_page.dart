import 'package:flutter/material.dart';
import 'package:test_app/model/dish_model.dart';
import 'package:test_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Dishes>> futureDishes;

  @override
  void initState() {
    super.initState();
    futureDishes = ApiServices.fetchDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe App')),
      body: FutureBuilder<List<Dishes>>(
        future: futureDishes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No dishes found'));
          } else {
            final dishes = snapshot.data!;
            return ListView.builder(
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(dish.image),
                    title: Text(dish.title),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
