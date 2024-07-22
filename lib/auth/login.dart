import 'dart:convert';
import 'package:Pilot/BottomNav/bottomNav.dart';
import 'package:Pilot/Utilities/airtime.dart';
import 'package:Pilot/auth/signup.dart';
import 'package:Pilot/pages/forgot-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool _obscureText = true;

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
          "Welcome",
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
                const SizedBox(height: 50),
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
                const Text(
                  'Password',
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
                    controller: passwordController,
                    hintText: 'Password',
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
                      text: "Login",
                      onPress: isLoading
                          ? null
                          : () {
                        setState(() {
                          isLoading = true;
                        });
                        loginUser(emailController.text, passwordController.text);
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
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF3730a3),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF667185),),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Color(0xFF3730a3),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 60), // Adjusted for bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {
    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String accessToken = responseData['access_token'];
      final user = responseData['user'];

      print('Login successful, token: $accessToken');
      print('User: $user');

      setState(() {
        isLoading = false;
      });

      // Navigate to Home page and pass the user object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: user),
        ),
      );
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
