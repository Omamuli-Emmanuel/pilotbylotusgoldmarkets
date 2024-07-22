import 'dart:convert';

import 'package:Pilot/payment_pages/failed.dart';
import 'package:Pilot/payment_pages/paymentWebview.dart';
import 'package:Pilot/payment_pages/successful.dart';
import 'package:flutter/material.dart';
import '../global_widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Payment extends StatefulWidget {
  final Map<String, dynamic> user;
  const Payment({required this.user});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController amountController = TextEditingController();
  final staticAuth = "base64:S4DkEB+PzxjzH7YmbUr20s4tWk3Idc4k/eLVyaopwyM=";

  bool _isProcessing = false;
  String _processingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deposit",
          style: TextStyle(
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
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text("How much would you like to deposit today?"),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: "20000",
              inputType: TextInputType.number,
              controller: amountController,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child:  Text("Charges may apply"),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: _isProcessing ? null : () {
                setState(() {
                  _isProcessing = true;
                  _processingMessage =
                  "We're initiating your payment, you will be redirected shortly";
                });
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentWebview(user: widget.user, amount: amountController.text,)));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Color(0xFF6366f1);
                  }
                  return Color(0xFF3730a3); // Change to your desired button color
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Adjust the rounded corners here
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity, // Full width button
                alignment: Alignment.center, // Center align text
                child: _isProcessing
                    ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                    : Text(
                  "Make payment",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            if (_processingMessage.isNotEmpty)
              Text(
                _processingMessage,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // void payNow() {
  //   double charge = double.parse(amountController.text) * 0.02;
  //   PayWithPayStack().now(
  //     context: context,
  //     secretKey: "sk_test_fabb4bc56db43b7b626da03650292c156ee851bd",
  //     customerEmail: "${widget.user["email"]}",
  //     reference: uniqueTransRef,
  //     currency: "NGN",
  //     amount: double.parse(amountController.text) + charge,
  //     transactionCompleted: () {
  //       print("Transaction Successful");
  //       creditUser(charge);
  //     },
  //     transactionNotCompleted: () {
  //       print("Transaction Not Successful!");
  //       setState(() {
  //         _isProcessing = false;
  //         _processingMessage = '';
  //       });
  //     },
  //     callbackUrl: 'https://lotusgoldmarkets.co/api/webhook/transaction-status',
  //   );
  // }


}
