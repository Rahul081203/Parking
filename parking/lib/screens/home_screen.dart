import 'package:flutter/material.dart';
import 'report_illegal.dart';
import 'search_screen.dart'; // Import your SearchScreen file
import 'list_screen.dart';   // Import your ListScreen file
import 'map_screen.dart';    // Import your MapScreen file

class HomeScreen extends StatefulWidget {
  final String userEmail; // Add a parameter to accept the user's email

  HomeScreen({required this.userEmail}); // Constructor to accept user's email

  @override
  _HomeScreenState createState() => _HomeScreenState(userEmail: userEmail);
}

class _HomeScreenState extends State<HomeScreen> {
  final String userEmail; // Store the user's email
  int _selectedIndex = 0;

  _HomeScreenState({required this.userEmail}); // Constructor to accept user's email

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("************************************************ User Email: $userEmail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                // Implement profile navigation here
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                // Implement settings navigation here
              },
            ),
            Divider(),
            ListTile(
              title: Text('Help'),
              leading: Icon(Icons.help),
              onTap: () {
                // Implement help navigation here
              },
            ),
          ],
        ),
      ),
      body: _buildScreenContent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Report',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildScreenContent() {
    switch (_selectedIndex) {
      case 0:
        return SearchScreen(); // SearchScreen here
      case 1:
        return ListScreen();   // ListScreen here
      case 2:
        return MapScreen();    // MapScreen here
      case 3:
        return ReportIllegalScreen(userEmail: userEmail); // ReportScreen here
      default:
        return Center(
          child: Text('Not implemented'),
        );
    }
  }
}
