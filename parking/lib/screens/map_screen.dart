import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Map Screen Content',
              style: TextStyle(fontSize: 20),
            ),
            // Add your map widget here
          ],
        ),
      ),
    );
  }
}
