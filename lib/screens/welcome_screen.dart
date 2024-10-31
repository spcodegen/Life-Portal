import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 125,
                        width: 125,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 200,
                        child: GestureDetector(
                          onTap: () {
                            //GoRouter.of(context).go("/decision");
                            Navigator.pushNamed(context, '/decision');
                          },
                          child: const CustomButton(
                            buttonName: "Get Started",
                            buttonColor: kWhite,
                            buttonTextColor: kBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
