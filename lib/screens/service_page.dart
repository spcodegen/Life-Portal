import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  final String nicNumber;

  const ServicePage({super.key, required this.nicNumber});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
            title: const Text("Service Page"),
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
                  '/Policyinfo',
                  imagePath: 'assets/policy.png',
                  nicNumber: widget.nicNumber,
                ),
                _buildButton(
                  context,
                  'Vehicle Inspection',
                  '/Inspection',
                  imagePath: 'assets/protection.png',
                  nicNumber: widget.nicNumber,
                ),
                _buildButton(
                  context,
                  'ARI',
                  null,
                  imagePath: 'assets/insurance.png',
                  nicNumber: widget.nicNumber,
                ),
                _buildButton(
                  context,
                  'Accident Report',
                  '/Accident',
                  imagePath: 'assets/crash.png',
                  nicNumber: widget.nicNumber,
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
                  url: 'https://ci.lk/complaint/',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    String? route, {
    String? imagePath,
    String? nicNumber,
    String? url,
  }) {
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
            _launchURL(url); // Launch URL if provided
          } else if (route != null && nicNumber != null) {
            // Pass NIC number if route is provided
            GoRouter.of(context).push(route, extra: nicNumber);
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
            const SizedBox(height: 8),
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
