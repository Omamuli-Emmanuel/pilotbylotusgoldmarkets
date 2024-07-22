import 'dart:convert';
import 'package:Pilot/BottomNav/bottomNav.dart';
import 'package:Pilot/Utilities/airtime.dart';
import 'package:Pilot/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'chat.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final String supportEmail = 'support@lotusgoldmarkets.co';
  final String supportPhone = '+234 903 894 2953';
  final String whatsappUrl = 'https://wa.me/2349038942953';
  bool isLoading = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Color(0xFF3730a3),
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                Text(
                  'If you\'ve forgotten your password, please enter your email address below to receive a password reset link. Follow the instructions in the email to reset your password.',
                  style: TextStyle(fontSize: 16),
                ),

                const Text(
                  'Email Address',
                  style: TextStyle(
                    color: Color(0xFF344054),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 10),
                CommonTextField(
                  hintText: "Email",
                  controller: emailController,
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20.0),
                Stack(
                  children: [
                    CommonButton(
                      text: "Reset password",
                      onPress: isLoading
                          ? null
                          : () {
                        setState(() {
                          isLoading = true;
                        });
                        forgotPass(emailController.text);
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
                // Adjusted for bottom spacing


                SizedBox(height: 20),
                Text(
                  'Important Notice:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'If you believe your account has been compromised, please contact our support team immediately for assistance. Ensuring the security of your account is our top priority.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Contact Support:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Image.asset("assets/socials/whatsapp.png", width: 50, height: 50,),
                  title: Text('Message us on WhatsApp', style: TextStyle(fontSize: 15),),
                  trailing: IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: () {
                      _launchURL(whatsappUrl);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.contact_support, size: 50, color: Color(0xFF3730a3),),
                  title: Text('Live chat with one of our agents', style: TextStyle(fontSize: 15),),
                  trailing: IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgotPass(String email) async {
    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/forgot-password';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'email': email,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData['code']),
        backgroundColor: Color(0xFF3730a3),
      ));


      // Navigate to Home page and pass the user object
    } else {
      // Login failed
      final data = json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["error"]),
        backgroundColor: Colors.red,
      ));
      setState(() {
        isLoading = false;
      });
    }
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
