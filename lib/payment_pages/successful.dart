import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';

class Successful extends StatefulWidget {
  final Map<String, dynamic> user;
  const Successful({required this.user});

  @override
  State<Successful> createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {
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
                  Text("Deposit successful", style: GoogleFonts.roboto(
                      fontWeight : FontWeight.w700,
                      fontSize: 20
                  ),),
                  Text("Your deposit was successful. Now you enjoy our value added services.", textAlign: TextAlign.center, style: GoogleFonts.roboto(
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
                child: Text("Goto dashboard", style: GoogleFonts.roboto(
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
