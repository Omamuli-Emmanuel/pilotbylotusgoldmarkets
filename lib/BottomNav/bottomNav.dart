import 'dart:convert';

import 'package:Pilot/auth/login.dart';
import 'package:Pilot/pages/Invest.dart';
import 'package:Pilot/pages/change-password.dart';
import 'package:Pilot/pages/settings.dart';
import 'package:Pilot/pages/support.dart';
import 'package:Pilot/pages/whitepaper.dart';
import 'package:Pilot/transactionPin/transaction_pin.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Withdraw/allWithdrawals.dart';
import '../pages/home.dart';
import '../pages/transfer.dart';
class BottomNav extends StatefulWidget {
  final Map<String, dynamic> user;
  final int initialPageIndex;
  const BottomNav({required this.user, this.initialPageIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;
  late List<Widget> _pages;
  final PageController _pageController = PageController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      Home(user: widget.user),
      Transfer(user: widget.user),
      Invest(user: widget.user,),
      Settings(user: widget.user,),
    ];
    _selectedIndex = widget.initialPageIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  final List<String> _pageTitles = [
    'Overview',
    'Utilities',
    'Invest',
    'My space',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex], style: GoogleFonts.dmSans(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20
        ),),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white), // Set the hamburger icon color to white
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.description, color: Color(0xFF6366f1),),
              title: Text('The Lotusgold Whitepaper', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: () {
                // Handle the whitepaper tap
                // Navigator.pop(context);
                // Navigate to the whitepaper page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhitePaperPage()),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.password, color: Color(0xFF6366f1),),
              title: Text('Set Transaction Pin', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionPin(user: widget.user,)),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.security, color: Color(0xFF6366f1),),
              title: Text('Change Password', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword(user: widget.user,)),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.wallet, color: Color(0xFF6366f1),),
              title: Text('Withdrawals', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllWithdrawals(user: widget.user),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 1,
              color: Colors.grey,
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.support, color: Color(0xFF6366f1),),
              title: Text('Contact Support', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFF6366f1),),
              title: Text('Sign Out', style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),),
              onTap: () {
                // Handle the sign out tap
                _signOut(context);
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // This is a placeholder function that currently does nothing
          // You can replace this with your actual refresh logic later
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(), // Disable page swiping
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Overview',
              backgroundColor: Color(0xFF3730a3),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_iphone_rounded),
              label: 'Utilities',
              backgroundColor: Color(0xFF3730a3),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_work),
              label: 'Invest',
              backgroundColor: Color(0xFF3730a3),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.private_connectivity),
              label: 'Space',
              backgroundColor: Color(0xFF3730a3),
            ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white54,
          backgroundColor: Color(0xFF3730a3), // Set the background color again
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _signOut(BuildContext context) {
    // Implement your sign-out logic here
    // For example, clear user session, tokens, etc.
    // After signing out, navigate to the login page and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
    );
  }
}

