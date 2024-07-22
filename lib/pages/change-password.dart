import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../auth/login.dart';
import '../auth/signup.dart';

class ChangePassword extends StatefulWidget {
  final Map<String, dynamic> user;
  const ChangePassword({required this.user});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading = false;
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  final List<String> _confirmPin = ['','','',''];
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title:  Text(
          'Change password',
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Password',
              style: TextStyle(
                color: Color(0xFF344054),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: CommonTextFieldPassword(
                controller: currentPasswordController,
                hintText: 'Current Password',
                fillColor: Colors.white,
                borderColor: Colors.grey,
                obscureText: _obscureText,
                onIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'New Password',
              style: TextStyle(
                color: Color(0xFF344054),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: CommonTextFieldPassword(
                controller: newPasswordController,
                hintText: 'New Password',
                fillColor: Colors.white,
                borderColor: Colors.grey,
                obscureText: _obscureText,
                onIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Confirm New Password',
              style: TextStyle(
                color: Color(0xFF344054),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: CommonTextFieldPassword(
                controller: confirmNewPasswordController,
                hintText: 'Confirm New Password',
                fillColor: Colors.white,
                borderColor: Colors.grey,
                obscureText: _obscureText,
                onIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            const SizedBox(height: 30.0),
            Stack(
              children: [
                CommonButton(
                  text: "Continue",
                  onPress: isLoading
                      ? null
                      : () {
                    setState(() {
                      isLoading = true;
                    });
                    _showBottomSheetConfirmPin(context);
                  },
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 60,
                        height: 60,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black),
                        //   shape: BoxShape.rectangle,
                        // ),
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
                        return SizedBox.shrink();
                      } else if (index == 10) {
                        return GestureDetector(
                          onTap: _removeLastDigit,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.backspace),
                          ),
                        );
                      } else if (index == 11) {
                        return GestureDetector(
                          onTap: () {
                            if (_confirmPin.every((digit) => digit.isNotEmpty)) {
                              changePassword();
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
                          child:Container(
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


  Future<void> changePassword() async {
    String newPassword = newPasswordController.text;
    String confirmNewPassword = confirmNewPasswordController.text;

    if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('New password and confirm new password do not match.'),
        backgroundColor: Colors.red,
      ));
      return; // Exit the method early
    }

    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/change-password';

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'oldPassword': currentPasswordController.text,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
        'pin': _confirmPin.join(),
        'uniqueId' : widget.user["uniqueId"]
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String message = responseData['code'];

      _signOut(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password changed successfully, proceed to login with new password."),
        backgroundColor: Colors.red,
      ));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
        backgroundColor: Colors.green,
      ));
    } else {
      // Login failed
      final data = json.decode(response.body);
      print(data);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _signOut(BuildContext context) {
    // Implement your sign-out logic here
    // For example, clear user session, tokens, etc.
    // After signing out, navigate to the login page and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
    );
  }

}

class CommonTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final IconData? suffixIcon;
  final bool obscureText;
  final Function onIconPressed;
  final IconData icon;

  CommonTextFieldPassword({
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.borderColor,
    required this.obscureText,
    required this.onIconPressed,
    required this.icon,
    this.suffixIcon,
  });

  @override
  _CommonTextFieldPasswordState createState() => _CommonTextFieldPasswordState();
}

class _CommonTextFieldPasswordState extends State<CommonTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(widget.icon),
          onPressed: () {
            widget.onIconPressed();
          },
        ),
      ),
    );
  }
}

