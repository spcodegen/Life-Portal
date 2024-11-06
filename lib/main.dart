import 'package:flutter/material.dart';
import 'package:life_portal_main/screens/about_page.dart';
import 'package:life_portal_main/screens/decision_screen.dart';
import 'package:life_portal_main/screens/login_screen.dart';
import 'package:life_portal_main/screens/main_menu_screen.dart';
import 'package:life_portal_main/screens/owner_vehicle_screen.dart';
import 'package:life_portal_main/screens/policyinfo.dart';
import 'package:life_portal_main/screens/register_screen.dart';
import 'package:life_portal_main/screens/service_page.dart';
import 'package:life_portal_main/screens/vehicle_details_screen.dart';
import 'package:life_portal_main/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const WelcomeScreen());
          case '/decision':
            return MaterialPageRoute(
                builder: (context) => const DecisionScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/about':
            return MaterialPageRoute(builder: (context) => const AboutPage());
          case '/main':
            if (args is String) {
              // Ensure you're passing nicNumber properly
              return MaterialPageRoute(
                builder: (context) => MainMenuScreen(nicNumber: args),
              );
            }
            return _errorRoute();
          case '/service':
            if (args is String) {
              return MaterialPageRoute(
                builder: (context) => ServicePage(nicNumber: args),
              );
            }
            return _errorRoute();
          case '/Policyinfo':
            if (args is String) {
              return MaterialPageRoute(
                builder: (context) => Policyinfo(nicNumber: args),
              );
            }
            return _errorRoute();
          case '/ownerscreen':
            if (args is String) {
              return MaterialPageRoute(
                builder: (context) => OwnerVehicleScreen(nicNumber: args),
              );
            }
            return _errorRoute();
          case '/vehicleDetails':
            return MaterialPageRoute(
                builder: (context) => const VehicleDetailsScreen());
          default:
            return _errorRoute();
        }
      },
    );
  }

  // Error route if the path does not match any valid route.
  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
