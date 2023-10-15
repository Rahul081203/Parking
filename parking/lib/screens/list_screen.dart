import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'List Screen Content',
              style: TextStyle(fontSize: 20),
            ),
            // Add your list of parking spaces widget here
          ],
        ),
      ),
    );
  }
}
