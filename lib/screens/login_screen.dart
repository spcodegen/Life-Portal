import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

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
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _nicController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/3.png'),
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
          body: SafeArea(
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
                          //form feild for the user name
                          TextFormField(
                            controller: _userNameController,
                            validator: (value) {
                              //check weather the user enterd a valid user name
                              if (value!.isEmpty) {
                                return "Please enter User Name";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'User Name',
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //form feild for the national ID
                          TextFormField(
                            controller: _nicController,
                            validator: (value) {
                              if (value!.isEmpty) {
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
                            height: 15,
                          ),

                          //form feild for the password
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Password";
                              }
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
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                //form is valid, process data
                                String userName = _userNameController.text;
                                String nic = _nicController.text;
                                String password = _passwordController.text;

                                print("$userName $nic $password");
                                GoRouter.of(context).push("/ownerscreen");
                              }
                            },
                            child: const CustomButton(
                              buttonName: "Login Now",
                              buttonColor: kWhite,
                              buttonTextColor: kBlack,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push("/register");
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
}
