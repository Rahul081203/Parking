import 'package:flutter/material.dart';
import 'search_screen.dart'; // Import your SearchScreen file
import 'list_screen.dart';   // Import your ListScreen file
import 'map_screen.dart';    // Import your MapScreen file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildScreenContent() {
    switch (_selectedIndex) {
      case 0:
        return SearchScreen(); // Use your SearchScreen here
      case 1:
        return ListScreen();   // Use your ListScreen here
      case 2:
        return MapScreen();    // Use your MapScreen here
      default:
        return Center(
          child: Text('Not implemented'),
        );
    }
  }
}
