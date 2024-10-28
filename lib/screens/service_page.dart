import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  void _launchURL(String url) async {
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Main Menu"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 1.5,
              children: [
                _buildButton(
                  context,
                  'Policy Information',
                  '/policyinfo',
                  imagePath: 'assets/policy.png',
                  //nicNumber: widget.nicNumber,
                ),
                _buildButton(
                  context,
                  'Vehicle Inspection',
                  '/Inspection',
                  imagePath: 'assets/protection.png',
                ),
                _buildButton(
                  context,
                  'ARI',
                  imagePath: 'assets/insurance.png',
                  null,
                ),
                _buildButton(
                  context,
                  'Accident Report',
                  '/Accident',
                  imagePath: 'assets/crash.png',
                ),
                _buildButton(
                  context,
                  'Third Party renewal',
                  null,
                  imagePath: 'assets/renewal.png',
                  url: 'https://online.ci.lk/third_party/',
                ),
                _buildButton(
                  context,
                  'Premium payment',
                  null,
                  imagePath: 'assets/pay.png',
                  url: 'https://online.ci.lk/general/',
                ),
                _buildButton(
                  context,
                  'Quotation',
                  null,
                  imagePath: 'assets/pay.png',
                  url: 'https://ci.lk/getamotorquote/',
                ),
                _buildButton(
                  context,
                  'Customer feedback',
                  null,
                  imagePath: 'assets/customer.png',
                  url: 'https://ci.lk/complaint/ ',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String? route,
      {String? imagePath, String? nicNumber, String? url}) {
    return SizedBox(
      width: 150,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 15,
          shadowColor: Colors.black,
        ),
        onPressed: () {
          if (url != null) {
            _launchURL(url);
          } else if (route != null) {
            GoRouter.of(context).push(route);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath,
                height: 60,
                width: 60,
              ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Georgia',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
