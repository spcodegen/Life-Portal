import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //form key for the form validation
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
                                if (value!.isEmpty) {
                                  return 'Please enter First Name';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter Last Name';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter User Name';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter National ID Number';
                                }
                                if (!RegExp(r'^\d{12}$').hasMatch(value) &&
                                    !RegExp(r'^\d{9}[vV]$').hasMatch(value)) {
                                  return 'Enter a 12-digit number or a 9-digit number followed by V or v';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }
                                if (value.length != 10) {
                                  return 'Mobile Number must be of 10 digit';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter E-Mail';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
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
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
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
                                  String firstName = firstname.text;
                                  String lastName = lastname.text;
                                  String userName = username.text;
                                  String nationalId = nationalID.text;
                                  String mobileNo = mobile.text;
                                  String emailAddress = email.text;
                                  String pass = password.text;

                                  print(
                                      "$firstName, $lastName, $userName, $nationalId, $mobileNo, $emailAddress, $pass");
                                }
                              },
                              child: const CustomButton(
                                buttonName: "Submit",
                                buttonColor: kWhite,
                                buttonTextColor: kBlack,
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
