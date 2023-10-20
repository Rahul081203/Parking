import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/parking_space_details_screen.dart';
import 'screens/reservation_confirmation_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/register_screen.dart';
import 'screens/report_illegal.dart'; // Import the report_illegal.dart file

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
        '/login': (context) => LoginScreen(
          onLoginSuccess: (String email) {
            print('Logged in with email: $email');
            // Add your navigation logic to the home screen here
            Navigator.pushNamed(context, '/home', arguments: email);
          },
        ),
        '/home': (context) => HomeScreen(userEmail: '',),
        '/parking_space_details': (context) => ParkingSpaceDetailsScreen(),
        '/reservation_confirmation': (context) => ReservationConfirmationScreen(),
        '/payment': (context) => PaymentScreen(),
        '/register': (context) => RegisterScreen(),
        '/report_illegal': (context) => ReportIllegalScreen(),
      },
    );
  }
}
