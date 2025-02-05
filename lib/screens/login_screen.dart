import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/screens/global_data.dart';
import 'package:life_portal_main/screens/register_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controller for the text from feilds
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _idNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static const _inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static const TextStyle _labelStyle = TextStyle(color: Colors.white);
  static const InputDecoration _inputDecoration = InputDecoration(
    labelStyle: _labelStyle,
    border: _inputBorder,
    focusedBorder: _inputBorder,
    enabledBorder: _inputBorder,
  );

  @override
  Widget build(BuildContext context) {
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
                vertical: 50,
                horizontal: 10,
              ),
              child: Column(
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  //login form
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          //User Text field
                          _buildTextField(
                            controller: _userNameController,
                            labelText: 'User Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter User Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //National ID Number Text field
                          _buildTextField(
                            controller: _idNumberController,
                            labelText: 'National ID Number',
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9vV]')),
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //
                          _buildTextField(
                            controller: _passwordController,
                            labelText: 'Password:',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 280,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.white60,
                                elevation: 10,
                                shadowColor: const Color.fromARGB(255, 6, 6, 6),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await _loginUser();
                                }
                              },
                              child: const Text(
                                'Login Now',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Georgia',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                              //GoRouter.of(context).push("/register");
                            },
                            child: const Text(
                              "Not registered yet? Register from here!",
                              style: TextStyle(
                                fontSize: 16,
                                color: kWhite,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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

  Future<void> _loginUser() async {
    final String username = _userNameController.text;
    final String idNumber = _idNumberController.text;
    final String password = _passwordController.text;

    final Uri apiUrl =
        Uri.parse('http://124.43.209.68:9010/api/v3/getBynic/$idNumber');

    try {
      final response =
          await http.get(apiUrl).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        if (decodedData is List) {
          final List<dynamic> userDataList = decodedData;

          if (userDataList.isNotEmpty &&
              userDataList[0] is Map<String, dynamic>) {
            final Map<String, dynamic> userData = userDataList[0];

            if (userData['user_name'] == username &&
                userData['password'] == password) {
              GlobalData.setLoggedInUserName(username);
              Navigator.pushReplacementNamed(
                context,
                '/ownerscreen',
                arguments: idNumber,
              );
              //GoRouter.of(context).push("/ownerscreen");
              print("ok 1");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid username or password')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No user data found')),
            );
          }
        } else if (decodedData is Map<String, dynamic>) {
          final Map<String, dynamic> userData = decodedData;

          if (userData['user_name'] == username &&
              userData['password'] == password) {
            GlobalData.setLoggedInUserName(username);
            Navigator.pushReplacementNamed(
              context,
              '/ownerscreen',
              arguments: idNumber,
            );
            print("ok 2");
            //GoRouter.of(context).push("/ownerscreen");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid username or password')),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Error fetching user data: ${response.statusCode}')),
        );
      }
    } on TimeoutException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred, please try again later')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred, please try again later')),
      );
    }
  }

// button text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    required String? Function(String?) validator,
  }) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: kWhite,
            fontSize: 15,
          ),
          hintStyle: const TextStyle(
            color: kWhite,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kRed,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(18),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
