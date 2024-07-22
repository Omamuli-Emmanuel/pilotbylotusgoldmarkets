import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';
import '../global_widgets/common_button.dart';



class BuyData extends StatefulWidget {
  final Map<String, dynamic> user;
  const BuyData({required this.user});

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  String _selectedNetwork = 'glo';
  String variantIdentity = '';
  String packageChosen = '';
  DataPackage? _selectedPackage;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool _isLoading = false;
  final List<String> _confirmPin = ['','','',''];

  final List<DataPackage> packages = [
    DataPackage(network: 'mtn', package: '500MB', duration: '30 Days', price: 199, variationId: '500'),
    DataPackage(network: 'mtn', package: '1GB', duration: '30 Days', price: 299, variationId: 'M1024'),
    DataPackage(network: 'mtn', package: '2GB', duration: '30 Days', price: 560, variationId: 'M2024'),
    DataPackage(network: 'mtn', package: '3GB', duration: '30 Days', price: 720, variationId: '3000'),
    DataPackage(network: 'mtn', package: '5GB', duration: '30 Days', price: 1310, variationId: '5000'),
    DataPackage(network: 'mtn', package: '6GB', duration: '7 Days', price: 1550, variationId: 'mtn-20hrs-1500'),
    DataPackage(network: 'mtn', package: '10GB', duration: '30 Days', price: 2560, variationId: '10000'),
    DataPackage(network: 'mtn', package: '30GB', duration: '30 Days', price: 7960, variationId: 'mtn-30gb-8000'),
    DataPackage(network: 'mtn', package: '40GB', duration: '30 Days', price: 9920, variationId: 'mtn-40gb-10000'),
    DataPackage(network: 'mtn', package: '75GB', duration: '30 Days', price: 14960, variationId: 'mtn-75gb-15000'),

    // DataPackage(network: 'airtel', package: '500MB', duration: '30 Days', price: 199.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '1GB', duration: '30 Days', price: 319.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '2GB', duration: '30 Days', price: 589.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '5GB', duration: '30 Days', price: 1399.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '10GB', duration: '30 Days', price: 2760.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '15GB', duration: '30 Days', price: 4060.0, variationId: '500'),
    // DataPackage(network: 'airtel', package: '20GB', duration: '30 Days', price: 5360.0, variationId: '500'),
    DataPackage(network: 'airtel', package: '750MB', duration: '14 Days', price: 375, variationId: 'airt-550'),
    DataPackage(network: 'airtel', package: '1GB', duration: '1 Day', price: 589, variationId: 'airt-330x'),
    DataPackage(network: 'airtel', package: '2GB', duration: '2 Days', price: 920, variationId: 'airt-500x'),
    DataPackage(network: 'airtel', package: '1.5GB', duration: '30 Days', price: 1130, variationId: 'airt-1100'),
    DataPackage(network: 'airtel', package: '2GB', duration: '30 Days', price: 1330, variationId: 'airt-1300'),
    DataPackage(network: 'airtel', package: '3GB', duration: '30 Days', price: 1690, variationId: 'airt-1650'),
    DataPackage(network: 'airtel', package: '4.5GB', duration: '30 Days', price: 2250, variationId: 'airt-2200'),
    DataPackage(network: 'airtel', package: '6GB', duration: '7 Days', price: 1690, variationId: 'airt-1650-2'),
    DataPackage(network: 'airtel', package: '10GB', duration: '30 Days', price: 3350, variationId: 'airt-3300'),
    DataPackage(network: 'airtel', package: '20GB', duration: '30 Days', price: 5540, variationId: 'airt-5500'),
    DataPackage(network: 'airtel', package: '40GB', duration: '30 Days', price: 10760, variationId: 'airt-11000'),

    // DataPackage(network: 'glo', package: '500MB', duration: '30 Days', price: 199.0, variationId: '500'),
    // DataPackage(network: 'glo', package: '1GB', duration: '30 Days', price: 320.0, variationId: ''),
    // DataPackage(network: 'glo', package: '2GB', duration: '30 Days', price: 590.0, variationId: '500'),
    // DataPackage(network: 'glo', package: '3GB', duration: '30 Days', price: 850.0, variationId: '500'),
    // DataPackage(network: 'glo', package: '5GB', duration: '30 Days', price: 1399.0, variationId: '500'),
    // DataPackage(network: 'glo', package: '10GB', duration: '30 Days', price: 2749.0, variationId: '500'),
    DataPackage(network: 'glo', package: '1GB', duration: '5 Nights', price: 150, variationId: 'glo100x'),
    DataPackage(network: 'glo', package: '1.25GB', duration: '1 Day (Sunday)', price: 250, variationId: 'glo200x'),
    DataPackage(network: 'glo', package: '1.35GB', duration: '14 Days', price: 550, variationId: 'G500'),
    DataPackage(network: 'glo', package: '2.9GB', duration: '30 Days', price: 1020, variationId: 'G1000'),
    DataPackage(network: 'glo', package: '5.8GB', duration: '30 Days', price: 1990, variationId: 'G2000'),
    DataPackage(network: 'glo', package: '7.7GB', duration: '30 Days', price: 2490, variationId: 'G2500'),
    DataPackage(network: 'glo', package: '10GB', duration: '30 Days', price: 2990, variationId: 'G3000'),
    DataPackage(network: 'glo', package: '13.25GB', duration: '30 Days', price: 3950, variationId: 'G4000'),
    DataPackage(network: 'glo', package: '18.25GB', duration: '30 Days', price: 4890, variationId: 'G5000'),
    DataPackage(network: 'glo', package: '29.5GB', duration: '30 Days', price: 7850, variationId: 'G8000'),
    DataPackage(network: 'glo', package: '50GB', duration: '30 Days', price: 9930, variationId: 'glo10000'),

    DataPackage(network: '9mobile', package: '1GB', duration: '30 Days', price: 1030, variationId: '9MOB1000'),
    DataPackage(network: '9mobile', package: '2.5GB', duration: '30 Days', price: 2030, variationId: '9MOB34500'),
    DataPackage(network: '9mobile', package: '11.5GB', duration: '30 Days', price: 7950, variationId: '9MOB8000'), // Add appropriate price
    DataPackage(network: '9mobile', package: '15GB', duration: '30 Days', price: 9920, variationId: '9MOB5000'),  // Add appropriate price
  ];
  List<DataPackage> get filteredPackages {
    return packages.where((package) => package.network == _selectedNetwork).toList();
  }


  void _showBottomSheetConfirmPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _confirmPin.length; i++) {
                  if (_confirmPin[i].isEmpty) {
                    _confirmPin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _confirmPin.length - 1; i >= 0; i--) {
                  if (_confirmPin[i].isNotEmpty) {
                    _confirmPin[i] = '';
                    break;
                  }
                }
              });
            }


            return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter transaction pin',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _confirmPin[index].isEmpty ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 9) {
                                return GestureDetector(
                                  onTap: _removeLastDigit,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.backspace),
                                  ),
                                );
                              } else if (index == 10) {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (index == 11) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_confirmPin.every((digit) => digit.isNotEmpty)) {
                                      _submitForm();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit((index + 1) % 10);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${(index + 1) % 10}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final double nairaBalance = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final formattedBalance = NumberFormat.currency(symbol: '₦').format(nairaBalance);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Buy data',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Select network provider",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRadioButton('glo', 'assets/images/glo.jpeg'),
                    SizedBox(width: 10),
                    _buildRadioButton('mtn', 'assets/images/mtn.png'),
                    SizedBox(width: 10),
                    _buildRadioButton('airtel', 'assets/images/airtel.jpeg'),
                    SizedBox(width: 10),
                    _buildRadioButton('9mobile', 'assets/images/nineMobile.png'),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Phone number",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                CommonTextField(
                  controller: phoneNumberController,
                  hintText: "0802XXXXXXX",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Select package",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField<DataPackage>(
                  value: _selectedPackage,
                  items: filteredPackages.map((package) {
                    return DropdownMenuItem<DataPackage>(
                      value: package,
                      child: Text('${package.package} - ${package.duration} - ₦${package.price}', style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400
                      ),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPackage = value;
                      if (value != null) {
                        amountController.text = value.price.toString();
                        variantIdentity = value.variationId.toString();
                        packageChosen = value.package.toString();
                      }
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF78716c),
                      ),
                    ),
                    Text(
                      "Balance : $formattedBalance",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF78716c),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CommonTextField(
                  controller: amountController,
                  hintText: "100",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
                  readOnly: true,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: CommonButton(
          onPress: () {
            _showBottomSheetConfirmPin(context);
          },
          text: "Continue",
        ),
      ),
    );

  }

  Widget _buildRadioButton(String value, String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNetwork = value;
          _selectedPackage = null;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedNetwork == value ? Color(0xFF3730a3) : Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _selectedNetwork == value
              ? [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ]
              : [],
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final phoneNumber = phoneNumberController.text;
    final amount = amountController.text;
    final pin = _confirmPin.join();

    if (phoneNumber.isEmpty || amount.isEmpty) {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final userAmount = double.tryParse(widget.user["naira_balance"].toString());
    final enteredAmount = double.tryParse(amountController.text);

    if (userAmount == null || enteredAmount == null) {
      // Show an error message if parsing fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid amount entered'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (userAmount < enteredAmount) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Insufficient balance'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (enteredAmount < 100.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Minimum amount is ₦100',
          style: GoogleFonts.roboto(fontSize: 14),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://www.lotusgoldmarkets.co/api/buy-data/${widget.user["uniqueId"]}/${_selectedNetwork}/${phoneNumber}/${amount}/${variantIdentity}/${packageChosen}/$pin')); // Replace with your API endpoint
    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Handle the response data
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Airtime purchase successful'),
        backgroundColor: Colors.green,
      ));
      final user = data['user'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: user),
        ),
      );
    } else {
      final data = json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
      // Navigator.pop(context);
    }
    }
  }


class DataPackage {
  final String network;
  final String package;
  final String duration;
  final int price;
  final String variationId;

  DataPackage({required this.network, required this.package, required this.duration, required this.price, required this.variationId});
}

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final TextInputType inputType;
  final IconData? suffixIcon;
  final bool readOnly;

  CommonTextField({
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.borderColor,
    required this.inputType,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }
}

