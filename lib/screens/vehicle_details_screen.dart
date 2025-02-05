import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/screens/global_data.dart';
import 'package:http/http.dart' as http;

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final vehicleNameController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerNICController = TextEditingController();
  final customerMobileNumberController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleYearController = TextEditingController();

  @override
  void dispose() {
    vehicleNameController.dispose();
    customerNameController.dispose();
    customerNICController.dispose();
    customerMobileNumberController.dispose();
    vehicleNumberController.dispose();
    vehicleModelController.dispose();
    vehicleYearController.dispose();
    super.dispose();
  }

  Future<void> _saveVehicleDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool consent = await _requestUserConsent();

      if (!consent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You need to consent to proceed")),
        );
        return;
      }

      String riskName = "new " + vehicleNumberController.text;
      GlobalData.setRiskName(riskName);

      final Map<String, dynamic> inputData = {
        'vehicle_details': vehicleNameController.text,
        'customer_name': customerNameController.text,
        'customer_nic': customerNICController.text,
        'mobile_no': customerMobileNumberController.text,
        'vehicle_no': vehicleNumberController.text,
        'vehicle_model': vehicleModelController.text,
        'manufactured_year': vehicleYearController.text,
      };

      try {
        final Uri apiUrl =
            Uri.parse('http://124.43.209.68:9010/api/v2/saveuser');
        final response = await http.post(
          apiUrl,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(inputData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Vehicle details saved successfully!')),
          );
          Navigator.pushNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Save vehicle details: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred, please try again later')),
        );
      }
    }
  }

  Future<bool> _requestUserConsent() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Data Collection Consent"),
          content: const Text(
              "We collect your vehicle and personal details to process your request. Your data is securely transmitted and not shared with third parties without your consent. Do you agree?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background-new.png'),
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
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildTextField('Your Name',
                                    customerNameController, screenWidth),
                                _buildTextField('Your NIC',
                                    customerNICController, screenWidth,
                                    keyboardType: TextInputType.text,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9vV]')),
                                      LengthLimitingTextInputFormatter(12),
                                    ],
                                    hintText:
                                        'E.g. 536467829390 or 1367289407V',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                _buildTextField('Your Mobile Number',
                                    customerMobileNumberController, screenWidth,
                                    keyboardType: TextInputType.phone,
                                    hintText: 'E.g. 0714563782',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                _buildTextField('Vehicle Make',
                                    vehicleNameController, screenWidth,
                                    hintText: 'E.g. Toyota',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                _buildTextField('Vehicle Number',
                                    vehicleNumberController, screenWidth,
                                    hintText: 'E.g. NW CBB-1226 or CBB 1226',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                _buildTextField('Vehicle Model',
                                    vehicleModelController, screenWidth,
                                    hintText: 'E.g. Corolla',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                _buildTextField('Vehicle Manufactured Year',
                                    vehicleYearController, screenWidth),
                                SizedBox(height: screenHeight * 0.03),

                                // Submit Button
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.01),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.02,
                                          horizontal: screenWidth * 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: Colors.white70,
                                      elevation: 10,
                                    ),
                                    onPressed: _saveVehicleDetails,
                                    child: Text(
                                      'Proceed to Inspection',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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

  Widget _buildTextField(
      String label, TextEditingController controller, double screenWidth,
      {TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatter,
      String? hintText,
      TextStyle? hintStyle}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          hintText: hintText,
          hintStyle: hintStyle,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == 'Your NIC') {
            if (!RegExp(r'^\d{12}$').hasMatch(value) &&
                !RegExp(r'^\d{9}[vV]$').hasMatch(value)) {
              return 'Enter a valid NIC: 12-digit number or 9-digit number followed by V or v';
            }
          }
          if (label == 'Vehicle Number') {
            if (!RegExp(r'^[A-Z]{1,2}\s?[A-Z]{2,3}\s?-?\s?\d{4}$')
                .hasMatch(value)) {
              return 'Please enter a valid vehicle number (e.g., NW CBB-1226 or CBB 1226)';
            }
          }
          if (label == 'Your Mobile Number') {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Please enter a valid mobile number (10 digits)';
            }
          }
          return null;
        },
        controller: controller,
      ),
    );
  }
}
