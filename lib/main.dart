import 'package:flutter/material.dart';
import 'package:life_portal_main/screens/decision_screen.dart';
import 'package:life_portal_main/screens/login_screen.dart';
import 'package:life_portal_main/screens/owner_vehicle_screen.dart';
import 'package:life_portal_main/screens/policyinfo.dart';
import 'package:life_portal_main/screens/register_screen.dart';
import 'package:life_portal_main/screens/service_page.dart';
import 'package:life_portal_main/screens/vehicle_details_screen.dart';
import 'package:life_portal_main/screens/welcome_screen.dart';
import 'package:life_portal_main/utils/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouterClass().router,
    );*/
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
          case '/Choises':
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
          /*case '/Inspection':
            return MaterialPageRoute(
                builder: (context) => const VehicleInspec());
          case '/Change':
            return MaterialPageRoute(
                builder: (context) => const ChangePassword());
          case '/onsite':
            return MaterialPageRoute(
                builder: (context) => const OnsiteInspection());*/
          default:
            return _errorRoute();
        }
      },
    );
  }

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
