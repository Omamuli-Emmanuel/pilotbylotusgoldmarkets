import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';

class Lowbalance extends StatefulWidget {
  final Map<String, dynamic> user;
  const Lowbalance({required this.user});

  @override
  State<Lowbalance> createState() => _LowbalanceState();
}

class _LowbalanceState extends State<Lowbalance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/failed.gif"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text("Subscription Failed", style: GoogleFonts.roboto(
                      fontWeight : FontWeight.w700,
                      fontSize: 20
                  ),),
                  SizedBox(
                    width: double.infinity,
                    child: Text("It appears your subscription failed due to insufficient amount in your naira wallet.", textAlign: TextAlign.center , style: GoogleFonts.roboto(
                        fontWeight : FontWeight.w400,
                        fontSize: 15
                    ),),
                  )
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
                child: Text("Go back to overview", style: GoogleFonts.roboto(
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
