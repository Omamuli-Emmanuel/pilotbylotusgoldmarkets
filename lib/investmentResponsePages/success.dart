
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';


class Success extends StatefulWidget {
  final Map<String, dynamic> package;
  final Map<String, dynamic> user;
  const Success({required this.package, required this.user});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/success.gif"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text("Subscription Success", style: GoogleFonts.roboto(
                      fontWeight : FontWeight.w700,
                      fontSize: 20
                  ),),
                  Text("You successfully subscribed to the ${widget.package["package_name"]}, for a total ROI of ${widget.package["roi_percent"]}%, your total profit will be ₦${widget.package["roi_amount"]} and you will receive ₦${widget.package["daily_roi"]} daily for a period of ${widget.package["duration"]} months", textAlign: TextAlign.center, style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNav(user: widget.user),
                ),
              );
            },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6366f1)), // Replace with desired color
                ),
                child: Text("Goto overview", style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w400
                ),)
            )
          ],
        ),
      ),
    );
  }
}
