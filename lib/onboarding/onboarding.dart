import 'package:flutter/material.dart';
import 'package:onboarding_slider_flutter/onboarding_slider_flutter.dart';
import '../auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();

  void initState() {
    super.initState();
    _requestPermissions();
    _configureFirebaseMessaging();
  }

  void _requestPermissions() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3730a3),
        ),
        backgroundColor: Color(0xFF3730a3),
        body: OnBoard(
          pageController: _pageController,
          onBoardData: onBoardData,
          titleStyles:   GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
          descriptionStyles:   GoogleFonts.dmSans(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          pageIndicatorStyle:  const PageIndicatorStyle(
            width: 50,
            inactiveColor: Color(0xff9CC2E1),
            activeColor: Colors.white,
            inactiveSize: Size(12, 5),
            activeSize: Size(12, 5),
          ),
          startButton: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
            },
            child: Container(
              width: 353,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Get started',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            color: Color(0xFF3730a3),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          imageWidth: double.infinity,
          showSkip: false,
          imageHeight: 320,
        ),
    );
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Pilot - the lotusgold app",
    description:
    "Join us in building a stable, gold-backed ecosystem. With Pilot, your funds are backed with gold "
        "reserves, shielding you from outside inflation and securing your financial future.",
    image: "assets/images/onboardingTwo.png",
  ),
  const OnBoardModel(
    title: "Earn Daily Returns",
    description:
    "Receive daily returns on your investments as we chart a course to the lotusgold token unveiling, track your earnings in real-time,"
        " and withdraw funds effortlessly. Your financial growth is our priority.",
    image: 'assets/images/onboardingOne.png',
  ),
  const OnBoardModel(
    title: "Transact in the lotus safe space",
    description:
    "All funds in the lotusgold ecosystem is backed with real and physical gold. Buy and sell with funds shielded from adverse impact of inflation",
    image: 'assets/images/onThreee.png',
  ),
];
