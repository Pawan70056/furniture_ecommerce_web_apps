import 'package:flutter/material.dart';

class ViewOrdersView extends StatelessWidget {
  const ViewOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: const Center(child: Text('Your orders here.')),
    );
  }
}
