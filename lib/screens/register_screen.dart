import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_portal_main/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final nationalID = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    username.dispose();
    nationalID.dispose();
    mobile.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _registerUser() async {
    // Prepare input data for registration
    final Map<String, dynamic> inputData = {
      'title': _title,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'user_name': username.text,
      'nic': nationalID.text,
      'mobile_no': mobile.text,
      'email': email.text,
      'password': password.text,
    };

    try {
      final Uri apiUrl =
          Uri.parse('http://124.43.209.68:9010/api/v3/saveOldCustomer');
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(inputData),
      );

      // Handle registration response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'An error occurred during registration, please try again later'),
        ),
      );
      print("Error during registration: $e");
    }
  }

  Future<bool> _requestUserConsent() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Data Collection Consent"),
          content: const Text(
              "We collect your personal details to process your registration. Your data is securely transmitted and not shared with third parties without your consent. Do you agree?"),
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //login form
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            //form feild for the Title
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: const TextStyle(
                                  color: kWhite,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: kGreen,
                                  ),
                                ),
                              ),
                              value: _title,
                              onChanged: (value) =>
                                  setState(() => _title = value),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a title';
                                }
                                return null;
                              },
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Mr.',
                                  child: Text('Mr.'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Mrs.',
                                  child: Text('Mrs.'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            //form feild for the first name
                            TextFormField(
                              controller: firstname,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter First Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'First Name',
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
                              height: 10,
                            ),

                            //form feild for the last name
                            TextFormField(
                              controller: lastname,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Last Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Last Name',
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
                              height: 10,
                            ),

                            //form feild for the user name
                            TextFormField(
                              controller: username,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter User Name';
                                }
                                if (value.length < 4) {
                                  return 'User name must be at least 4 characters long';
                                }
                                if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                                  return 'First letter must be capital';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'User Name',
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
                              height: 10,
                            ),

                            //form feild for the ID number
                            TextFormField(
                              controller: nationalID,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9vV]'))
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter National ID Number';
                                }
                                if (!RegExp(r'^\d{12}$').hasMatch(value) &&
                                    !RegExp(r'^\d{9}[vV]$').hasMatch(value)) {
                                  return 'Enter a 12-digit number or a 9-digit number followed by V or v';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'National ID Number',
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
                              height: 10,
                            ),

                            //form feild for the mobile number
                            TextFormField(
                              controller: mobile,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }
                                if (value.length != 10) {
                                  return 'Mobile number must be exactly 10 digits';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Mobile Number',
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
                              height: 10,
                            ),

                            //form feild for the email
                            TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter E-Mail';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email Address',
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
                              height: 10,
                            ),

                            TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
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
                            SizedBox(
                              width: 500,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: Colors.green,
                                  elevation: 20,
                                  shadowColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final nic = nationalID.text;

                                    // Request user consent
                                    bool consent = await _requestUserConsent();

                                    if (!consent) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "You need to consent to proceed"),
                                        ),
                                      );
                                      return; // Exit if user does not consent
                                    }

                                    // Prepare the URL to check NIC
                                    final Uri checkNicUrl = Uri.parse(
                                        'http://124.43.209.68:9010/api/v3/getBynic/$nic');

                                    try {
                                      final checkResponse =
                                          await http.get(checkNicUrl);

                                      if (checkResponse.statusCode == 200) {
                                        final responseData =
                                            jsonDecode(checkResponse.body);

                                        // Debugging: Print the response data to the console to inspect the structure
                                        print("Response data: $responseData");

                                        // Check if 'responseData' is a list
                                        if (responseData is List &&
                                            responseData.isNotEmpty) {
                                          // Loop through the list and check if any user with the same NIC exists
                                          for (var user in responseData) {
                                            if (user['nic'] == nic) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'A user with this NIC already exists.'),
                                                ),
                                              );
                                              return; // Exit, user with NIC found
                                            }
                                          }

                                          // If no user with the same NIC is found, proceed with registration
                                          _registerUser();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'No user found with this NIC. Proceeding to register.'),
                                            ),
                                          );
                                          _registerUser(); // Proceed with registration
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Error checking NIC. Please try again.'),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // Catch any exceptions that occur during the request
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'An error occurred, please try again later'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Register Me',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'Georgia',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
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
      ),
    );
  }
}
