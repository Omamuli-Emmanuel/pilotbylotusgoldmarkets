import 'dart:convert';

import 'package:Pilot/BLOCs/allWithdrawals.dart';
import 'package:Pilot/BLOCs/transactions.dart';
import 'package:Pilot/Withdraw/sendToBank.dart';
import 'package:Pilot/pages/profilepicture.dart';
import 'package:Pilot/pages/whitepaper.dart';
import 'package:Pilot/payment_pages/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Kyc_pages/instructions.dart';
import '../Withdraw/allWithdrawals.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> user;
  const Home({required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isBalanceVisible = true;
  late TransactionsBloc _transactionsBloc;
  List<dynamic> _withdrawalRequests = [];

  @override
  void initState() {
    super.initState();
    _transactionsBloc = TransactionsBloc();
    _transactionsBloc.add(FetchTransactions(widget.user['uniqueId'] as String));

    Withdrawals();
  }

  @override
  Widget build(BuildContext context) {
    final double nairaBalance = double.tryParse(widget.user["naira_balance"].toString()) ?? 0.0;
    final formattedBalance = NumberFormat.currency(symbol: '₦').format(nairaBalance);
    final String lotusBalance = widget.user["dollar_savings_balance"].toString() ?? '0.0';

    return BlocProvider(
      create: (context) => _transactionsBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePicture(user: widget.user)));
                    },
                    child: ClipOval(
                      child: Image.network(
                        "${widget.user["picture"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Hello, ${widget.user["first_name"]}", style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Let's get you started in your journey to beat inflation.", style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  SizedBox(height: 5,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 130, // Adjust height as needed
                child: PageView(
                  children: [
                    _buildBalanceContainer("${widget.user["refId"]}", formattedBalance),
                    _buildBalanceContainer("${widget.user["refId"]}", "$lotusBalance LGD"),
                  ],
                ),
              ),
            ),

            widget.user["kyc"].toString() == "No"
                ? GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => KYCInstructions(user: widget.user)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFdc2626),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center( // Center the text within the container
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_outlined, color: Colors.white, size: 15,),
                      SizedBox(width: 5,),
                      Text(
                        "Complete your KYC to be eligible for withdrawals.",
                        textAlign: TextAlign.center, // Center the text
                        style: GoogleFonts.dmSans(
                          color: Colors.white, // Set text color to white for better contrast
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
                : widget.user["kyc"].toString() == "Pending"
                ? Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
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
              child: Center( // Center the text within the container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Color(0xFFd97706),
                      height: 30,
                      width: 5,
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info, color: Colors.amber, size: 20,),
                        SizedBox(width: 5,),
                        Text(
                          "Your kyc status is pending",
                          textAlign: TextAlign.center, // Center the text
                          style: GoogleFonts.dmSans(
                            color: Colors.black, // Set text color to white for better contrast
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )
                : Container(),
            // SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment(user: widget.user)));
                    },
                    child: _buildCircleContainerQuicklinks(Icons.arrow_circle_down, "Deposit"),
                  ),

                  GestureDetector(
                    onTap: () {
                      showSnackbar(context, "This feature will be released soon.");
                    },
                    child:  _buildCircleContainerQuicklinks(Icons.cloud_sync, "Swap"),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendToBank(user: widget.user)));
                    },
                    child: _buildCircleContainerQuicklinks(Icons.wallet, "Withdraw"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WhitePaperPage()));
                    },
                    child: _buildCircleContainerQuicklinks(Icons.chrome_reader_mode, "Docs"),
                  ),
                ],
              ),
            ),

            _withdrawalRequests.isNotEmpty ?  GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllWithdrawals(user: widget.user),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF6366f1),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming payout", style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                    SizedBox(height: 10),
                    ..._withdrawalRequests.map((request) => Row(children: [Text(
                      NumberFormat.currency(symbol: '₦').format(double.parse(request['amount'])),
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: Colors.white
                      ),
                    ), SizedBox(width: 10,), Icon(Icons.circle, color: Colors.amberAccent, size: 15,)],)).toList(),
                  ],
                ),
              ),
            ) : Container(),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: Text("Recent Activities", textAlign: TextAlign.start, style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<TransactionsBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 130),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (state is TransactionError) {
                      return Center(child: Text(state.message));
                    } else if (state is TransactionLoaded) {
                      if (state.transactions.isEmpty) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "You have no transactions yet\n make a deposit to get started.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(fontSize: 15),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Payment(user: widget.user),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFF3730a3),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text("Fund wallet"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(height: 3),
                            RefreshIndicator(
                              onRefresh: () async {
                                context.read<TransactionsBloc>().add(
                                  RefreshTransactions(widget.user['uniqueId'] as String),
                                );
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = state.transactions[index];
                                  final amount = double.tryParse(transaction['amount'].toString()) ?? 0.0;
                                  final formattedAmount = NumberFormat.currency(symbol: '₦').format(amount);

                                  final DateTime createdAt = DateTime.parse(transaction['created_at']);
                                  final String formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);
                                  final String formattedTime = DateFormat('hh:mm a').format(createdAt);

                                  return Container(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            color: Color(0xFF6366f1),
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                              child: Icon(
                                                Icons.add_alert_rounded,
                                                color: Colors.white,
                                                size: 18, // Adjust icon size relative to the container size
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (transaction["type"] == "Lotusgold bonus") ...[
                                                Text(
                                                  '+ ${transaction["amount"]} LGD',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF16a34a),
                                                  ),
                                                )
                                              ] else if (transaction["type"] == "Credit")  ...[
                                                Text(
                                                  '+ $formattedAmount',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF16a34a),
                                                  ),
                                                )
                                              ] else if (transaction["type"] == "Daily ROI") ...[
                                                Text(
                                                  '+ $formattedAmount',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF16a34a),
                                                  ),
                                                )
                                              ] else if (transaction["type"] == "Investment plan" || transaction["type"] == "Debit") ...[
                                                Text(
                                                  '- $formattedAmount',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFdc2626),
                                                  ),
                                                ),
                                              ],
                                              SizedBox(height: 5),
                                              Text(
                                                transaction["narration"],
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                  color:  Color(0xFF4F4F4F)
                                                ),
                                              ),
                                              Text(
                                                '$formattedDate : $formattedTime',
                                                style: GoogleFonts.dmSans(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceContainer(String balanceType, String formattedBalance) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xFF3730a3),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet Balance",
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    size: 18,
                    color: Colors.white,
                    _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBalanceVisible = !_isBalanceVisible;
                    });
                  },
                ),
              ],
            ),
            Text(
              _isBalanceVisible ? formattedBalance : '****',
              style: GoogleFonts.roboto(
                fontSize: 27,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: Text("<<< Swipe right / left for other balance >>>", textAlign: TextAlign.center, style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 10
              ),),
            )
          ]
      ),
    );
  }

  Widget _buildCircleContainerQuicklinks(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: 80,
      width: 80,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(15.0),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       blurRadius: 1,
      //     ),
      //   ],
      // ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF6366f1), size: 25,),
          SizedBox(height: 5),
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> Withdrawals() async {

    try {
      final response = await http.get(Uri.parse('https://www.lotusgoldmarkets.co/api/pull-withdrawals/${widget.user["uniqueId"]}'));

      if (response.statusCode == 200) {
      final  data = json.decode(response.body);
      setState(() {
        _withdrawalRequests = data['transactions'] as List<dynamic>;
      });
          print(_withdrawalRequests);
      } else {

      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_clock, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.dmSans(
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