import 'package:flutter/material.dart';

class FeaturedCollectionView extends StatelessWidget {
  const FeaturedCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Featured Collection')),
      body: const Center(child: Text('Featured Collection of Furniture.')),
    );
  }
}
