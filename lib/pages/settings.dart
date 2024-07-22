import 'package:Pilot/Transfer/sendMoney.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Settings extends StatefulWidget {
  final Map<String, dynamic> user;
  const Settings({required this.user});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = true;
  List<dynamic> referrals = [];
  List<dynamic> filteredReferrals = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchReferrals();
    searchController.addListener(filterReferrals);
  }

  Future<void> fetchReferrals() async {
    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/referrals/${widget.user["refId"]}'; // Replace with your actual API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          referrals = data['List'] ?? [];
          filteredReferrals = referrals;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load referrals');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void filterReferrals() {
    setState(() {
      filteredReferrals = referrals.where((referral) =>
          referral['name'].toLowerCase().contains(searchController.text.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Refer \n& Earn from your space",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Earn lotusgold 0.0001 token(s) when anyone from your space subscribes to an investment package and ₦10 anytime anyone from your space buys a data plan, pays cable or electricity bills.",
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      "Pilot is loading users in your space",
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            else if (filteredReferrals.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "User not found.",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "You have not referred anyone.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Share your referral code with your friends.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.user["refId"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF3730a3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.user["refId"].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Keep sharing your referral code: ${widget.user["refId"]}",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // SizedBox(height: 10),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Referrals',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredReferrals.length,
                        itemBuilder: (context, index) {
                          final referral = filteredReferrals[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SendMoney(user: widget.user, referral: referral),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: ClipOval(
                                child: Image.network(
                                  referral['picture'],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(referral['name']),
                              subtitle: Text(referral['email']),
                              trailing: Icon(
                                Icons.circle,
                                color: referral['kyc'] == "Yes" ? Colors.green : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
