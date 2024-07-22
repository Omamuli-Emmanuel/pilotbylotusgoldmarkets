import 'package:flutter/material.dart';

import 'onboarding.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 4), ()async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Onboarding()));
      });
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 200,),
          Container(
            width: double.infinity,
              padding: const EdgeInsets.only(left: 60, right: 60, top: 60, bottom: 20),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Image.asset(
                  'assets/images/playstore.png',
                  height: 100,
                  width: 100,
                ),
              ),
          ),
          // const Text("Pilot", style: TextStyle(
          //   color: Color(0xFF3730a3),
          //   fontSize: 26,
          //   fontWeight: FontWeight.w600
          // )),
          const Spacer(),

          const Text("from"),
          SizedBox(height: 3,),
          const Text("lotusgold markets", style: TextStyle(
            fontWeight: FontWeight.w400
          ),),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
