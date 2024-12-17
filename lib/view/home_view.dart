import 'package:flutter/material.dart';

// Define constants for styling
const Color kPrimaryColor = Colors.black;
const Color kSecondaryColor = Colors.grey;
const Color kBackgroundColor = Colors.white;
const double kPadding = 16.0;

// HomeScreen Widget
class HomeView extends StatelessWidget {
  HomeView({super.key});

  // Categories Data
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.star, 'label': 'Popular'},
    {'icon': Icons.chair, 'label': 'Chair'},
    {'icon': Icons.table_chart, 'label': 'Table'},
    {'icon': Icons.weekend, 'label': 'Armchair'},
    {'icon': Icons.bed, 'label': 'Bed'},
    {'icon': Icons.light, 'label': 'Lamp'},
  ];

  // Product Data
  final List<Map<String, String>> products = [
    {
      'name': 'Black Simple Lamp',
      'price': 'Rs. 500',
      'image': 'assets/images/lamp.png',
    },
    {
      'name': 'Minimal Stand',
      'price': 'Rs. 1500',
      'image': 'assets/images/stand.png',
    },
    {
      'name': 'Coffee Chair',
      'price': 'Rs. 1000',
      'image': 'assets/images/chair.png',
    },
    {
      'name': 'Simple Desk',
      'price': 'Rs. 3000',
      'image': 'assets/images/desk.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: _buildCategories(),
          ),
          const SizedBox(height: 16),

          // Product Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: _buildProductGrid(),
            ),
          ),
        ],
      ),
    );
  }

  // Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: kPrimaryColor),
        onPressed: () {
          // Menu action
        },
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make home',
            style: TextStyle(fontSize: 14, color: kSecondaryColor),
          ),
          Text(
            'BEAUTIFUL',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: kPrimaryColor),
          onPressed: () {
            // Search action
          },
        ),
      ],
    );
  }

  // Build Categories Section
  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> category = entry.value;

          bool isSelected = index == 0; // Mark first category as selected
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryColor : kSecondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: isSelected ? kBackgroundColor : kPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category['label'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? kPrimaryColor : kSecondaryColor,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Build Product Grid Section
  Widget _buildProductGrid() {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  // Build Product Card
  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kSecondaryColor,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                product['image'] ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          // Product Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'] ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Product Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Text(
              product['price'] ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
