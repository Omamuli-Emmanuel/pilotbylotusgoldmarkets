import 'package:Pilot/pages/investmentRules.dart';
import 'package:Pilot/pages/pickapackage.dart';
import 'package:flutter/material.dart';
import '../BLOCs/investments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Invest extends StatefulWidget {
  final Map<String, dynamic> user;
  const Invest({required this.user});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  late InvestBloc _investBloc;

  @override
  void initState() {
    super.initState();
    _investBloc = InvestBloc();
    _investBloc.add(FetchInvestments(widget.user['uniqueId'] as String));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _investBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<InvestBloc, InvestState>(
            builder: (context, state) {
              if (state is InvestLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is InvestLoadedState && state.investments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have not invested in a package, pick a package now to begin earning daily income",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvestmentPage(uniqueId: widget.user["uniqueId"])));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF3730a3),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text("Choose a package"),
                      )
                    ],
                  ),
                );
              } else if (state is InvestLoadedState) {
                return Column(
                  children: [
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            "My package(s)",
                            style: GoogleFonts.dmSans(fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvestmentRules()));
                          },
                          child: Icon(Icons.info, color: Color(0xFF3730a3), size: 30,),
                        )
                      ],
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _investBloc.add(RefreshInvestments(widget.user['uniqueId'] as String));
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: state.investments.map((investment) {
                                final amount = double.tryParse(investment['amount'].toString()) ?? 0.0;
                                final formattedAmount = NumberFormat.currency(symbol: '₦').format(amount);

                                final tRoi = double.tryParse(investment['roi_amount'].toString()) ?? 0.0;
                                final formattedAmountRoiT = NumberFormat.currency(symbol: '₦').format(tRoi);

                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
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
                                              '${investment['package_name']}',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF3730A3),
                                              ),
                                            ),
                                            Text(
                                              formattedAmount,
                                              style: GoogleFonts.roboto(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF000000),
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
                                                  'Total ROI: ',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                                Text(
                                                  '$formattedAmountRoiT',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Daily ROI: ',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                                Text(
                                                  ' ₦${investment['daily_roi']}',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Duration: ',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                                Text(
                                                  ' ${investment['duration']} Months',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'End date: ',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                                Text(
                                                  '${investment['end_date']}',
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "Error loading investments.",
                    style: GoogleFonts.dmSans(fontSize: 15),
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: BlocBuilder<InvestBloc, InvestState>(
          builder: (context, state) {
            if (state is InvestLoadedState && state.investments.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvestmentPage(uniqueId: widget.user["uniqueId"])));
                },
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Color(0xFF3730a3),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _investBloc.close();
    super.dispose();
  }
}
