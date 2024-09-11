import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

class OwnerVehicleScreen extends StatefulWidget {
  const OwnerVehicleScreen({super.key});

  @override
  State<OwnerVehicleScreen> createState() => _OwnerVehicleScreenState();
}

class _OwnerVehicleScreenState extends State<OwnerVehicleScreen> {
  String? _title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Vehicles",
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
                    const Text(
                      "Select Your Car!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //drop down button
                    SizedBox(
                      width: 250,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Option',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelStyle: const TextStyle(
                            color: kBlack,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: kGreen,
                            ),
                          ),
                          /*enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kGreen,
                            ),
                          ),*/
                        ),
                        value: _title,
                        onChanged: (value) => setState(
                          () => _title = value,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a title';
                          } else {
                            return null;
                          }
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Car 1',
                            child: Text('Car 1'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Car 2',
                            child: Text('Car 2'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Car 3',
                            child: Text('Car 3'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Car 4',
                            child: Text('Car 4'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    SizedBox(
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push("/main");
                        },
                        child: const CustomButton(
                          buttonName: "Let's Proceed",
                          buttonColor: kGreen,
                          buttonTextColor: kBlack,
                        ),
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
