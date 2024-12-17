import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/view/view_orders_view.dart';
import 'package:funiture_ecommerce/view/profile_view.dart';
import 'package:funiture_ecommerce/view/wishlist_view.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Welcome!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Wishlist'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistView()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.track_changes),
            title: const Text('View Orders'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ViewOrdersView()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
            ),
          ),
        ],
      ),
    );
  }
}
