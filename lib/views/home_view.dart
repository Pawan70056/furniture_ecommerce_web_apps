import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/data/categories_data.dart';
import 'package:funiture_ecommerce/data/new_arrivals_data.dart';
import 'package:funiture_ecommerce/views/about_app_view.dart';
import 'package:funiture_ecommerce/views/categories_view.dart';
import 'package:funiture_ecommerce/views/settings_view.dart';
import 'package:funiture_ecommerce/views/view_orders_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo/Logo.png'), // Your logo asset
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Navigate to a Favorites page (or implement functionality here)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Placeholder(), // Replace with your Favorites view
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Open the notification drawer
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoriesView()),
                );
              },
            ),
            ListTile(
              title: const Text('View Orders'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewOrdersView()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsView()),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutAppView()),
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Order #1234 has been shipped!'),
              subtitle: const Text('2 hours ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('New furniture collections are now available!'),
              subtitle: const Text('1 day ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Flash sale starts in 30 minutes!'),
              subtitle: const Text('1 day ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Reminder: 20% off coupon expires tomorrow!'),
              subtitle: const Text('2 days ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Reminder: 20% off coupon expires tomorrow!'),
              subtitle: const Text('2 days ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Reminder: 20% off coupon expires tomorrow!'),
              subtitle: const Text('2 days ago'),
              onTap: () {
                // Handle notification tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search for Products, Brands and more',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Banner Section
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/banner.png'), // Your banner asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to Categories View
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesView()),
                      );
                    },
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          icon: Icon(
                            categories[index]['icon'] as IconData?,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Implement category-specific navigation or functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${categories[index]['name']} clicked!'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categories[index]['name'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),

              // New Arrivals Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Arrivals',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to New Arrivals View
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Placeholder(), // Replace with your New Arrivals View
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newArrivals.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        newArrivals[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(Icons.favorite_border,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            newArrivals[index]['title']!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            newArrivals[index]['price']!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Customer Favorites Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Customer Favorites',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to New Arrivals View
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Placeholder(), // Replace with your New Arrivals View
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Example count
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/sample.jpg'), // Example asset
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(Icons.favorite_border,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Product Name',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Price',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Featured Collections Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Collections',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to New Arrivals View
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Placeholder(), // Replace with your New Arrivals View
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Example count
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/sample.jpg'), // Example asset
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(Icons.favorite_border,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Collection Name',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Price',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
