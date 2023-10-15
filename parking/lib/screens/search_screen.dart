import 'package:flutter/material.dart';
import 'parking_space_details_screen.dart'; // Import your ParkingSpaceDetailsScreen file
import 'reservation_confirmation_screen.dart'; // Import your ReservationConfirmationScreen file
import 'payment_screen.dart'; // Import your PaymentScreen file

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // Sample Parking Spot
            ListTile(
              title: Text('Parking Spot 1'),
              subtitle: Text('Availability: Available\nPrice: \$10/hr'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ParkingSpaceDetailsScreen()));
              },
            ),
            Divider(), // Add a divider for separation

            // Sample Parking Spot
            ListTile(
              title: Text('Parking Spot 2'),
              subtitle: Text('Availability: Not Available\nPrice: \$15/hr'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationConfirmationScreen()));
              },
            ),
            Divider(),

            // Sample Parking Spot
            ListTile(
              title: Text('Parking Spot 3'),
              subtitle: Text('Availability: Available\nPrice: \$12/hr'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
