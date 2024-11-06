import 'package:flutter/material.dart';
import 'package:life_portal_main/screens/about_page.dart';
import 'package:life_portal_main/screens/service_page.dart';

class MainMenuScreen extends StatefulWidget {
  final String nicNumber;

  const MainMenuScreen({super.key, required this.nicNumber});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 0;

  final _page = [
    ServicePage(nicNumber: ""), // Corrected: widget.nicNumber
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Update the ServicePage to use the correct NIC number
    _page[0] =
        ServicePage(nicNumber: widget.nicNumber); // Pass NIC to ServicePage

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
      body: _page[_selectedIndex], // Display the selected page
    );
  }
}
