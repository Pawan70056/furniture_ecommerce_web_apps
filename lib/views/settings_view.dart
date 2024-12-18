import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.brown,
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
            title: Text('Updates'),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: Text('Personal Info'),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: Text('Change Country'),
            onTap: () {
              // Navigate to terms of service
            },
          ),
        ],
      ),
    );
  }
}
