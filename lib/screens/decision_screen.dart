import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/2.png"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Are you an existing customers?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //GoRouter.of(context).push("/login");
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text("Yes"),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //GoRouter.of(context).push("/vehicleDetails");
                          Navigator.pushNamed(context, '/vehicleDetails');
                        },
                        child: const Text("No"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
