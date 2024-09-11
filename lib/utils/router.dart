import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/data/user.dart';
import 'package:life_portal_main/screens/decision_screen.dart';
import 'package:life_portal_main/screens/main_menu_screen.dart';
import 'package:life_portal_main/screens/login_screen.dart';
import 'package:life_portal_main/screens/owner_vehicle_screen.dart';
import 'package:life_portal_main/screens/register_screen.dart';
import 'package:life_portal_main/screens/vehicle_details_screen.dart';
import 'package:life_portal_main/screens/welcome_screen.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage<dynamic>(
          child: Scaffold(
        body: Center(
          child: Text("This page is not found!!!"),
        ),
      ));
    },

    //redirect to login page if useris not logged in
    /*redirect: (context, state) {
      bool isUserLoggedIn = UserData.isUserLoggedIn;

      if (isUserLoggedIn) {
        return "/home";
      } else {
        return "/";
      }
    },*/

    routes: [
      //Home Screen
      GoRoute(
        name: "welcome",
        path: "/",
        builder: (context, state) {
          return const WelcomeScreen();
        },
      ),

      //Decision Screen
      GoRoute(
        name: "decision",
        path: "/decision",
        builder: (context, state) {
          return const DecisionScreen();
        },
      ),

      //Login Screen
      GoRoute(
        name: "login",
        path: "/login",
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      //Vehicle Details Screen
      GoRoute(
        name: "vehicleDetails",
        path: "/vehicleDetails",
        builder: (context, state) {
          return const VehicleDetailsScreen();
        },
      ),

      //Register Screen
      GoRoute(
        path: "/register",
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),

      //Home Screen
      GoRoute(
        path: "/main",
        builder: (context, state) {
          return const MainMenuScreen();
        },
      ),

      //ownervehicle Screen
      GoRoute(
        path: "/ownerscreen",
        builder: (context, state) {
          return const OwnerVehicleScreen();
        },
      ),
    ],
  );
}
