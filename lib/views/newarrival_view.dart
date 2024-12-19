import 'package:flutter/material.dart';

class NewarrivalView extends StatelessWidget {
  const NewarrivalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Arrivals')),
      body: const Center(child: Text('Your New Arrivals Furniture.')),
    );
  }
}
