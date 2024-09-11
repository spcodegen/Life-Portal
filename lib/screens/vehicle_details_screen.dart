import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vehicle details",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //form feild for the vehicle make
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Vehicle Make',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //form feild for the vehicle model
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Vehicle Model',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //form feild for the vehicle year
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Vehicle Year',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push("/main");
                      },
                      child: const CustomButton(
                        buttonName: "Let's Proceed",
                        buttonColor: kGreen,
                        buttonTextColor: kBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
