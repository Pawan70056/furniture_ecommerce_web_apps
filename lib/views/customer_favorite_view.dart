import 'package:flutter/material.dart';

class CustomerFavoriteView extends StatelessWidget {
  const CustomerFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Favorites')),
      body: const Center(child: Text('Customer Favorites Furniture.')),
    );
  }
}
