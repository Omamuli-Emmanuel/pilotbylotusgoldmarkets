import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../BottomNav/bottomNav.dart';
import '../global_widgets/common_button.dart';

class SendMoney extends StatefulWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> referral;
  const SendMoney({required this.user, required this.referral});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool _isLoading = false;
  final List<String> _confirmPin = ['','','',''];

  @override
  Widget build(BuildContext context) {

    final double nairaBalance = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final formattedBalance = NumberFormat.currency(symbol: '₦').format(nairaBalance);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send money',
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
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text(
                          "From",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF78716c),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          "Balance : $formattedBalance",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF78716c),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  CommonTextFieldReadOnlyText(
                    hintText: "${widget.user["name"]}",
                    fillColor: Colors.white,
                    borderColor: Colors.grey,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "To",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF78716c),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  CommonTextFieldReadOnlyText(
                    hintText: "${widget.referral["name"]}",
                    fillColor: Colors.white,
                    borderColor: Colors.grey,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Amount",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF78716c),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  CommonTextField(
                    controller: amountController,
                    hintText: "100",
                    fillColor: Colors.white,
                    borderColor: Colors.grey,
                    inputType: TextInputType.number,
                    suffixIcon: Icons.numbers,
                  ),
                  SizedBox(height: 20), // Adjust spacing before the button
                  CommonButton(
                    onPress: () {
                      _showBottomSheetConfirmPin(context);
                    },
                    text: "Continue",
                  ),
                  SizedBox(height: 20), // Adjust spacing after the button
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(color: Colors.white,),
            ),
        ],
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
    setState(() {
      _isLoading = true;
    });

    final amount = amountController.text;
    final pin = _confirmPin.join();

    final userAmount = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final enteredAmount = double.tryParse(amount) ?? 0.0;

    if (userAmount < enteredAmount) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Insufficient balance'),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          'https://www.lotusgoldmarkets.co/api/send-money/${widget.user["uniqueId"]}/${widget.referral["uniqueId"]}/${amount}/${pin}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        // Handle the response data
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Transfer successful'),
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
        print(data);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data["message"] ?? 'An error occurred'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again.'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class CommonTextFieldReadOnlyText extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final TextInputType inputType;
  final bool readOnly;

  CommonTextFieldReadOnlyText({
    required this.hintText,
    required this.fillColor,
    required this.borderColor,
    required this.inputType,
    this.readOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
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
