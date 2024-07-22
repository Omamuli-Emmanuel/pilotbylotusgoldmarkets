import 'package:Pilot/Utilities/airtime.dart';
import 'package:Pilot/Utilities/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Transfer extends StatefulWidget {
  final Map<String, dynamic> user;
  const Transfer({required this.user});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Airtime(user: widget.user,)));
                   },
                   child: _buildCircleContainerQuicklinks(Icons.mobile_screen_share_rounded, "Buy Airtime"),
                 ),
                 GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyData(user: widget.user,)));
                   },
                   child: _buildCircleContainerQuicklinks(Icons.signal_wifi_statusbar_connected_no_internet_4, "Buy Data"),
                 ),
                 _buildCircleContainerQuicklinks(Icons.tv, "Cable Bills"),
               ],
             ),
            SizedBox(width: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircleContainerQuicklinks(Icons.electric_bolt_outlined, "Electricity Bills"),
                GestureDetector(
                  onTap: (){
                    showSnackbar(context, "This feature will be released soon.");
                  },
                  child: _buildCircleContainerQuicklinks(Icons.card_giftcard, "Trade Gift Cards"),
                ),
                GestureDetector(
                  onTap: (){
                    showSnackbar(context, "This feature will be released soon.");
                  },
                  child: _buildCircleContainerQuicklinks(Icons.credit_card, "Get Virtual Cards"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCircleContainerQuicklinks(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),

            blurRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF6366f1), size: 25,),
          SizedBox(height: 5),
          Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_clock, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),)
        ],
      ),
      backgroundColor: Color(0xFF3730a3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
