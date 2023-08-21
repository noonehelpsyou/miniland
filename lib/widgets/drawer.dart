import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle drawer item tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Handle drawer item tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more ListTiles for additional menu items
        ],
      ),
    );
  }
}
