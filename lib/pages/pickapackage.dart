import 'package:Pilot/investmentResponsePages/lowBalance.dart';
import 'package:Pilot/investmentResponsePages/success.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvestmentPackage {
  final String name;
  final double amount;
  final double returnRate;
  final int duration;
  final int bonusLGD;
  final double lgdValue;
  final String details;

  InvestmentPackage({
    required this.name,
    required this.amount,
    required this.returnRate,
    required this.duration,
    required this.bonusLGD,
    required this.lgdValue,
    required this.details,
  });

  String get formattedAmount => '₦${amount.toStringAsFixed(0)}';
  String get formattedBonusValue => '₦${(bonusLGD * lgdValue).toStringAsFixed(0)}';
}

class InvestmentPage extends StatelessWidget {
  final String uniqueId;
  final List<InvestmentPackage> packages = [
    InvestmentPackage(
      name: "Starter Package",
      amount: 50000,
      returnRate: 20,
      duration: 12,
      bonusLGD: 2,
      lgdValue: 5000,
      details: "This package is perfect if you're new to investing and want to start with a lower entry point. Enjoy a competitive return rate and potential future value from your bonus LGD tokens.",
    ),
    InvestmentPackage(
      name: "Bronze Package",
      amount: 100000,
      returnRate: 30,
      duration: 12,
      bonusLGD: 5,
      lgdValue: 5000,
      details: "If you're looking for a balance between risk and reward, this package offers a higher return rate. Your bonus LGD tokens hold future value, adding extra benefits to your investment.",
    ),
    InvestmentPackage(
      name: "Silver Package",
      amount: 250000,
      returnRate: 40,
      duration: 24,
      bonusLGD: 15,
      lgdValue: 5000,
      details: "Aiming for higher returns over a longer period? This medium-tier package includes a substantial bonus LGD that will significantly boost your investment value when redeemable.",
    ),
    InvestmentPackage(
      name: "Gold Package",
      amount: 500000,
      returnRate: 50,
      duration: 24,
      bonusLGD: 30,
      lgdValue: 5000,
      details: "For serious investors, this package offers substantial returns with a longer commitment. The generous bonus LGD adds significant future benefits.",
    ),
    InvestmentPackage(
      name: "Platinum Package",
      amount: 1000000,
      returnRate: 60,
      duration: 36,
      bonusLGD: 60,
      lgdValue: 5000,
      details: "Our top-tier package is designed for high-net-worth individuals. Enjoy high returns and a significant stake in Lotusgold, with substantial bonus LGD enhancing your investment.",
    ),
  ];

  InvestmentPage({required this.uniqueId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Pick a package",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover our exclusive investment packages and start growing your wealth with Lotusgold. Each package offers attractive returns and bonus Lotusgold (LGD) tokens, which hold significant future value. Choose the package that best suits your financial goals and join our community of investors today.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 20),
              ...packages.map((package) => InvestmentPackageCard(package: package, uniqueId: uniqueId)).toList(),
              SizedBox(height: 20),
              Text(
                'Key Features',
                style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '• High Returns: Enjoy attractive growth opportunities with our high return rates.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              Text(
                '• Bonus Lotusgold: Receive bonus Lotusgold as part of your investment package, enhancing your investment value.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              Text(
                '• Future Potential of LGD: Our LGD tokens will become redeemable in the fourth quarter of Stage 2 of the project, potentially increasing in value significantly.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              Text(
                '• Frequent Withdrawals: Enjoy unlimited withdrawal periods, allowing you to access your returns regularly.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              Text(
                '• Growth Potential: Benefit from the increasing value of your investments and bonus Lotusgold as Lotusgold continues to grow.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Future Redeemability and Value of LGD',
                style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Lotusgold (LGD) will become redeemable in the fourth quarter of Stage 2 of the project. You will be able to use LGD for withdrawals or to purchase goods and services within the Lotusgold ecosystem. The potential value of LGD is significant, given our plan to back it with physical gold and the expected increase in demand. As an early investor, you can benefit greatly from the appreciation of LGD, making the bonus LGD a valuable addition to your investment portfolio.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestmentPackageCard extends StatefulWidget {
  final InvestmentPackage package;
  final String uniqueId;

  InvestmentPackageCard({required this.package, required this.uniqueId});

  @override
  _InvestmentPackageCardState createState() => _InvestmentPackageCardState();
}

class _InvestmentPackageCardState extends State<InvestmentPackageCard> {
  bool _isLoading = false;

  void _investNow(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    // Build the URL parameters
    final url = Uri.parse(
      'https://www.lotusgoldmarkets.co/api/invest/${widget.package.name}/${widget.package.amount}/${widget.package.returnRate}/${widget.package.duration}/${widget.package.bonusLGD}/${widget.uniqueId}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Handle the response data
        print('Investment successful: $responseData');
        if (responseData["message"] == "Success") {
          final package = responseData["package"];
          final user = responseData["user"];
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Success(package: package, user: user)));
        } else if (responseData["message"] == "Bounce") {
          final user = responseData["user"];
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Lowbalance(user: user)));
        } else if (responseData["message"] == "Failed") {
          final user = responseData["user"];
          // Handle failed case
        }
      } else {
        print('Failed to invest: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.package.name,
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3730a3)),
            ),
            SizedBox(height: 10),
            Text(
              'Investment Amount: ${widget.package.formattedAmount}',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Text(
              'Return Rate: ${widget.package.returnRate}% per annum',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Text(
              'Investment Duration: ${widget.package.duration} month(s)',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Text(
              'Withdrawal: Unlimited',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Text(
              'Bonus Lotusgold (LGD): ${widget.package.bonusLGD} LGD',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Text(
              'Potential Value of Bonus LGD: ${widget.package.formattedBonusValue}',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              widget.package.details,
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            SizedBox(height: 10),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () => _investNow(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF3730a3),
              ),
              child: Text('Invest Now'),
            ),
          ],
        ),
      ),
    );
  }
}
