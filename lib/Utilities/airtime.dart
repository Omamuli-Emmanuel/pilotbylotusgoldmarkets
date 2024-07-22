import 'dart:convert';
import 'package:Pilot/global_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';

class Airtime extends StatefulWidget {
  final Map<String, dynamic> user;
  const Airtime({required this.user});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  String _selectedValue = 'glo';
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool _isLoading = false;
  final List<String> _confirmPin = ['','','',''];

  @override
  Widget build(BuildContext context) {
    final double nairaBalance = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final formattedBalance = NumberFormat.currency(symbol: '₦').format(nairaBalance);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Buy airtime',
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
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text("Select network provider", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c)
                  ),),
                ),
                SizedBox(height: 10,),
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
                SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: Text("Phone number", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c)
                  ),),
                ),
                SizedBox(height: 5,),
                CommonTextField(
                  controller: phoneNumberController,
                  hintText: "0802XXXXXXX",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text("Amount", style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF78716c)
                      ),),
                    ),
                    SizedBox(
                      child: Text("Balance : $formattedBalance", style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF78716c)
                      ),),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(height: 5,),
                CommonTextField(
                  controller: amountController,
                  hintText: "100",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
                ),
                Spacer(),
                CommonButton(
                  onPress: (){
                    _showBottomSheetConfirmPin(context);
                  },
                  text: "Continue",
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String value, String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedValue = value;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedValue == value ? Color(0xFF3730a3) : Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _selectedValue == value
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

    if (userAmount < enteredAmount ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Insufficient balance'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (enteredAmount < 100.0 ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Minimum amount is ₦100', style: GoogleFonts.roboto(
            fontSize: 14
        ),),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://www.lotusgoldmarkets.co/api/buy-airtime/${widget.user["uniqueId"]}/${_selectedValue}/${phoneNumber}/${amount}/${pin}')); // Replace with your API endpoint

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
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

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_clock, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),)
        ],
      ),
      backgroundColor: Color(0xFF3730a3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
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
