import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global_widgets/common_button.dart';
import '../global_widgets/custom_text_form_field.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  bool _isChecked = false;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController referredByController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
          "Create account",
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
                SizedBox(height: 50, width: double.infinity),
                const Text(
                  'First Name',
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
                  hintText: "First Name",
                  controller: firstnameController,
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 10, width: double.infinity),
                const Text(
                  'Last Name',
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
                  hintText: "Last Name",
                  controller: lastnameController,
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 10, width: double.infinity),
                const Text(
                  'Referred By',
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
                  hintText: "Referred By",
                  controller: referredByController,
                  fillColor: Colors.white,
                  borderColor: Colors.grey,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10, width: double.infinity),
                const Text(
                  'Email ',
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to ',
                              style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.0, // Adjusted height from 0.12 to 1.0
                              ),
                            ),
                            TextSpan(
                              text: 'Data Protection Policy',
                              style: TextStyle(
                                color: Color(0xFF2F4A9A),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 1.0,
                                // Adjusted height from 0.12 to 1.0
                                letterSpacing: -0.06,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.0, // Adjusted height from 0.12 to 1.0
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF2F4A9A),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 1.0,
                                // Adjusted height from 0.12 to 1.0
                                letterSpacing: -0.06,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30, width: double.infinity),
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: CommonButton(
                    text: "Create Account",
                    onPress: _isChecked && !isLoading
                        ? () {
                      signup(context);
                    }
                        : null,
                    child: isLoading
                        ? const SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                        : null,
                  ),
                ),
                SizedBox(height: 20, width: double.infinity),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF667185),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.0, // Adjusted height from 0.10 to 1.0
                        ),
                      ),
                      Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xFF2F4A9A),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.0, // Adjusted height from 0.10 to 1.0
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          // Some code to undo the change if necessary.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


Future<void> signup(BuildContext context) async {
  setState(() {
    isLoading = true;
  });


  final String apiUrl = 'https://www.lotusgoldmarkets.co/api/signup';
  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({
      'fname': firstnameController.text,
      'lname': lastnameController.text,
      'email': emailController.text,
      'refId': referredByController.text,
      'password': passwordController.text,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Login successful
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if(responseBody['message'] == "Success"){
      showSnackbar(context, "Account created successfully..");
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }

  } else {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    showSnackbar(context, "Signup failed: ${responseBody['error']}");
    setState(() {
      isLoading = false;
    });

  }
}






}

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Widget? child;

  const CommonButton({
    required this.text,
    this.onPress,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPress == null ? Colors.grey : Color(0xFF3730a3),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Adjust the value to reduce the rounded border
        ),
      ),
      child: child ?? Text(text, style: TextStyle(color: Colors.white)),
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
