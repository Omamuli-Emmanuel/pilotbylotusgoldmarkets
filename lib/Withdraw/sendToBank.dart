import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../BottomNav/bottomNav.dart';
import '../Kyc_pages/instructions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../global_widgets/common_button.dart';

class SendToBank extends StatefulWidget {
  final Map<String, dynamic> user;
  const SendToBank({required this.user});

  @override
  State<SendToBank> createState() => _SendToBankState();
}

class _SendToBankState extends State<SendToBank> {
  Banks? _seleectedBank;
  late String thebank = "";
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool _isLoading = false;
  final staticAuth = "base64:S4DkEB+PzxjzH7YmbUr20s4tWk3Idc4k/eLVyaopwyM=";
  final List<String> _confirmPin = ['', '', '', ''];

  final List<Banks> packages = [
    Banks("Access Bank Plc"),
    Banks("Citibank Nigeria Limited"),
    Banks("Dot Microfinance Bank"),
    Banks("Ecobank Nigeria"),
    Banks("FairMoney Microfinance Bank"),
    Banks("Fidelity Bank Plc"),
    Banks("First Bank of Nigeria Limited"),
    Banks("First City Monument Bank Limited"),
    Banks("Globus Bank Limited"),
    Banks("Guaranty Bank Plc"),
    Banks("Jaiz Bank Plc"),
    Banks("Keystone Bank Limited"),
    Banks("Kuda Bank"),
    Banks("Lotus Bank"),
    Banks("Moniepoint Microfinance Bank"),
    Banks("Opay"),
    Banks("Optimus Bank Limited"),
    Banks("Palmpay"),
    Banks("Parallex Bank Limited"),
    Banks("Polaris Bank Limited"),
    Banks("PremiumTrust Bank Limited"),
    Banks("Providus Bank Limited"),
    Banks("Rubies Bank"),
    Banks("Signature Bank Limited"),
    Banks("Sparkle Bank"),
    Banks("Stanbic IBTC Bank Plc"),
    Banks("Standard Chartered"),
    Banks("Sterling Bank Plc"),
    Banks("SunTrust Bank Nigeria Limited"),
    Banks("TAJBank Limited"),
    Banks("Titan Trust Bank Limited"),
    Banks("Union Bank of Nigeria Plc"),
    Banks("Unity Bank Plc"),
    Banks("United Bank for Africa Plc"),
    Banks("VFD Microfinance Bank"),
    Banks("Wema Bank Plc"),
    Banks("Zenith Bank Plc"),
  ];


  @override
  Widget build(BuildContext context) {
    final double nairaBalance = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final formattedBalance = NumberFormat.currency(symbol: '₦').format(nairaBalance);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Withdraw',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: widget.user["kyc"] == "No" ? Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("It seems your KYC status is still pending. Kindly complete your KYC in order to proceed to making withdrawals.",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => KYCInstructions(user: widget.user)));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFdc2626),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center( // Center the text within the container
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Start KYC",
                          textAlign: TextAlign.center, // Center the text
                          style: GoogleFonts.roboto(
                            color: Colors.white, // Set text color to white for better contrast
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ) : Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Select Bank",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c),
                    ),
                  ),
                ),
                DropdownButtonFormField<Banks>(
                  value: _seleectedBank,
                  items: packages.map((package) {
                    return DropdownMenuItem<Banks>(
                      value: package,
                      child: Text(
                        package.name,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _seleectedBank = value;
                      thebank = value!.name;
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
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Account Number",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF78716c),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                CommonTextField(
                  controller: accountNumberController,
                  hintText: "1003XXXXXX",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
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
                      "Balance: $formattedBalance",
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
                  hintText: "1000",
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                  suffixIcon: Icons.numbers,
                  readOnly: false,
                ),
                Spacer(),
                CommonButton(
                  onPress: () {
                    _showBottomSheetConfirmPin(context);
                  },
                  text: "Continue",
                ),
                SizedBox(height: 20),
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
    final accountNumber = accountNumberController.text;
    final amount = amountController.text;
    final bank = thebank;
    final pin = _confirmPin.join();

    if (accountNumber.isEmpty || amount.isEmpty) {
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

    if (enteredAmount < 1000.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Minimum amount is ₦1000',
          style: GoogleFonts.roboto(fontSize: 14),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/withdraw-to-bank';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'uniqueId': widget.user["uniqueId"],
        'name' : widget.user["name"],
        'email': widget.user["email"],
        'phone' : widget.user["phone"],
        'account' : accountNumberController.text,
        'pin' : pin,
        'bank' : bank,
        'amount': amountController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': staticAuth,
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Handle the response data
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Withdrawal request successfully placed.'),
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
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
      // Navigator.pop(context);
    }
  }
}

class Banks {
  final String name;

  Banks(this.name);
}

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final TextInputType inputType;
  final IconData suffixIcon;
  final bool readOnly;

  CommonTextField({
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.borderColor,
    required this.inputType,
    required this.suffixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor),
        ),
        suffixIcon: Icon(suffixIcon),
      ),
    );
  }
}

