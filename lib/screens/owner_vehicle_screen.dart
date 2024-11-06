import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_portal_main/constants/colors.dart';
import 'package:life_portal_main/screens/global_data.dart';
import 'package:life_portal_main/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class Vehicle {
  final String id;
  final String name;

  Vehicle({required this.id, required this.name});
}

class OwnerVehicleScreen extends StatefulWidget {
  final String nicNumber;

  const OwnerVehicleScreen({super.key, required this.nicNumber});

  @override
  State<OwnerVehicleScreen> createState() => _OwnerVehicleScreenState();
}

class _OwnerVehicleScreenState extends State<OwnerVehicleScreen> {
  String? _selectedVehicleId;
  bool _isCarVisible = false;
  bool _isVehiclesLoaded = false;
  List<Vehicle> _vehicleList = [];
  //String? _title;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isCarVisible = true;
      });
    });

    _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    try {
      final Uri apiUrl = Uri.parse(
          'http://124.43.209.68:9000/api/v1/getuserbyid/${widget.nicNumber}');

      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        final List<Vehicle> vehicles =
            jsonResponse.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;
          return Vehicle(
            id: '$index',
            name: (item['riskname']?.toString().trim() ?? 'Unknown'),
          );
        }).toList();

        setState(() {
          _vehicleList = vehicles;
          _isVehiclesLoaded = true;

          if (!_vehicleList
              .any((vehicle) => vehicle.id == _selectedVehicleId)) {
            _selectedVehicleId = null;
          }
        });
      } else {
        throw Exception(
            'Failed to load vehicles, status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isVehiclesLoaded = false;
        _vehicleList = [];
        _selectedVehicleId = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load vehicles. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isProceedEnabled = _isVehiclesLoaded &&
        (_selectedVehicleId != null && _selectedVehicleId!.isNotEmpty);
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
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 150),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Select Your Vehicle!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      _isVehiclesLoaded
                          ? (_vehicleList.isNotEmpty
                              ? DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Select Vehicle No:',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                  ),
                                  value: _selectedVehicleId,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedVehicleId = value;

                                      final selectedVehicle =
                                          _vehicleList.firstWhere(
                                              (vehicle) => vehicle.id == value);
                                      GlobalData.setRiskName(
                                          selectedVehicle.name);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a vehicle';
                                    }
                                    return null;
                                  },
                                  items: _vehicleList.map((vehicle) {
                                    return DropdownMenuItem<String>(
                                      value: vehicle.id,
                                      child: Text(vehicle.name),
                                    );
                                  }).toList(),
                                )
                              : Text('No vehicles found.'))
                          : (_vehicleList.isEmpty
                              ? CircularProgressIndicator()
                              : Text('Loading vehicles...')),
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: isProceedEnabled
                              ? Color.fromARGB(255, 51, 212, 37)
                              : Colors.grey,
                          elevation: 20,
                          shadowColor: const Color.fromARGB(255, 0, 0, 0),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: isProceedEnabled
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/main',
                                  arguments: widget.nicNumber,
                                );
                              }
                            : null,
                        child: Text(
                          'Let\'s Proceed',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Georgia',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /*Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          "Select Your Vehicle!",
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
                              buttonColor: kWhite,
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
          ),*/
        ),
      ),
    );
  }
}
