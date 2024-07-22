import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class AllWithdrawals extends StatefulWidget {
  final Map<String, dynamic> user;
  const AllWithdrawals({required this.user});

  @override
  State<AllWithdrawals> createState() => _AllWithdrawalsState();
}

class _AllWithdrawalsState extends State<AllWithdrawals> {
  List<dynamic> _processingRequests = [];
  List<dynamic> _paidRequests = [];

  @override
  void initState() {
    super.initState();
    fetchWithdrawals();
  }

  Future<void> fetchWithdrawals() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.lotusgoldmarkets.co/api/pull-all-withdrawals/${widget.user["uniqueId"]}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _processingRequests = data['transactions'].where((w) => w['status'] == 'Processing').toList();
          _paidRequests = data['transactions'].where((w) => w['status'] == 'Paid').toList();

          _processingRequests.sort((a, b) => a['created_at'].compareTo(b['created_at']));
          _paidRequests.sort((a, b) => a['created_at'].compareTo(b['created_at']));
        });
        print(_processingRequests);
        print(_paidRequests);
      } else {
        print('Failed to load withdrawals');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
  }

  String calculatePayoutDate(String createdAt, int hours) {
    final createdDate = DateTime.parse(createdAt);
    final payoutDate = createdDate.add(Duration(hours: hours));
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(payoutDate);
  }

  Widget buildWithdrawalCard(dynamic withdrawal, Color backgroundColor, Color textColor) {
    final formattedAmount = NumberFormat.currency(symbol: '₦').format(int.parse(withdrawal['amount']));
    final formattedCreatedAt = formatDate(withdrawal['created_at']);
    final minPayoutDate = calculatePayoutDate(withdrawal['created_at'], 24);
    final maxPayoutDate = calculatePayoutDate(withdrawal['created_at'], 72);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${withdrawal['preferred_bank']}',
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Text(
                  formattedAmount,
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          Container(width: double.infinity, height: 1, color: Colors.grey,),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Number: ',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '${withdrawal['accNumber']}',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '${withdrawal['status']}',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created At: ',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      formattedCreatedAt,
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Min Payout Date: ',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      minPayoutDate,
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Max Payout Date: ',
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      maxPayoutDate,
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pending Withdrawals',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: _processingRequests.isEmpty && _paidRequests.isEmpty
              ? Container(
            width: double.infinity,
            height: 400,
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator()
              ],
            )),
          )
              : Column(
            children: [
              if (_processingRequests.isNotEmpty) ...[
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     'Processing',
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF3730A3),
                //     ),
                //   ),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _processingRequests.length,
                  itemBuilder: (context, index) {
                    final withdrawal = _processingRequests[index];
                    return buildWithdrawalCard(
                      withdrawal,
                      index == 0 ? Color(0xFF3730A3) : Colors.white,
                      index == 0 ? Colors.white : Colors.black,
                    );
                  },
                ),
              ],
              if (_paidRequests.isNotEmpty) ...[
                SizedBox(height: 20,),
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     'Paid',
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF3730A3),
                //     ),
                //   ),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _paidRequests.length,
                  itemBuilder: (context, index) {
                    final withdrawal = _paidRequests[index];
                    return buildWithdrawalCard(
                      withdrawal,
                      Color(0xFF6366f1),
                      Colors.white,
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
