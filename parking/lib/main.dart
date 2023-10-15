import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/parking_space_details_screen.dart';
import 'screens/reservation_confirmation_screen.dart';
import 'screens/payment_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ParkingApp());
}

class ParkingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/parking_space_details': (context) => ParkingSpaceDetailsScreen(),
        '/reservation_confirmation': (context) => ReservationConfirmationScreen(),
        '/payment': (context) => PaymentScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
