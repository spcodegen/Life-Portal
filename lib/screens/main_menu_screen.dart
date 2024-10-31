import 'package:flutter/material.dart';
import 'package:life_portal_main/screens/about_page.dart';
import 'package:life_portal_main/screens/service_page.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 0;

  final _page = [
    //const ServicePage(),
    const AboutPage(),
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
            icon: Icon(Icons.insights_outlined),
            label: "Service",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.teal[900],
        iconSize: 25,
      ),
      body: _page[_selectedIndex],
    );
  }
}
