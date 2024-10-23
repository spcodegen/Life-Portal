import 'package:flutter/material.dart';
import 'package:life_portal_main/screens/about_page.dart';
import 'package:life_portal_main/screens/feedback_page.dart';
import 'package:life_portal_main/screens/main_page.dart';
import 'package:life_portal_main/screens/products_page.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 0;

  final _page = [
    const MainPage(),
    const AboutPage(),
    const ProductsPage(),
    const FeedbackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_rounded),
            label: "Product",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "Feedback",
          ),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
      ),
      body: _page[_selectedIndex],
    );
  }
}
