import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: false, // Replace with dynamic state
            onChanged: (bool value) {
              // Handle dark mode toggle
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: Text('Terms of Service'),
            onTap: () {
              // Navigate to terms of service
            },
          ),
        ],
      ),
    );
  }
}
