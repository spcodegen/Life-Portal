import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Text(
                            "Vehicle details",
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          //form feild for the Customer Name
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Customer Name',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Customer NIC
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Customer NIC',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Customer Mobile Number
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Customer Mobile Number',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Vehicle Name
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Vehicle Name',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Vehicle Number
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Vehicle Number',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Vehicle Model
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Vehicle Model',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the Vehicle Manufactured Year
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Vehicle Manufactured Year',
                              hintStyle: const TextStyle(
                                color: kWhite,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.all(18),
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
                              buttonColor: kWhite,
                              buttonTextColor: kBlack,
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
