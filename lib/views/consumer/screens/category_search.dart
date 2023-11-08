import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String name;

  Category({required this.icon, required this.name});
}

class CategoryInterface extends StatelessWidget {
  final List<Category> categories = [
    Category(icon: Icons.restaurant, name: 'Food'),
    Category(icon: Icons.hotel, name: 'Khách sạn'),
    //Category(icon: Icons.shopping_cart, name: 'Mua sắm'),
    //Category(icon: Icons.local_movies, name: 'Rạp chiếu phim'),
    Category(icon: Icons.work, name: 'Gym'),
    Category(icon: Icons.work, name: 'Gym'),
    Category(icon: Icons.work, name: 'Gym'),
    Category(icon: Icons.work, name: 'Gym'),
    Category(icon: Icons.work, name: 'Gym'),
    Category(icon: Icons.directions_run, name: 'Gym'),
    Category(icon: Icons.directions_run, name: 'Gym'),
    Category(icon: Icons.directions_run, name: 'Gym'),
    Category(icon: Icons.directions_run, name: 'Gym'),
    Category(icon: Icons.directions_run, name: 'Gym'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh mục'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(categories[index].icon),
            title: Text(categories[index].name),
          );
        },
      ),
    );
  }
}