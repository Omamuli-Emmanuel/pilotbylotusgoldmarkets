import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentRules extends StatefulWidget {
  const InvestmentRules({super.key});

  @override
  State<InvestmentRules> createState() => _InvestmentRulesState();
}

class _InvestmentRulesState extends State<InvestmentRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Investment terms",
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Investment Rules and Details',
                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'As part of your investment in Lotusgold, kindly be aware of the following rules:',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '1. The investment duration is generally fixed. However, in cases of emergency, you may close your investment early by contacting support. Please note that closing your package early will attract a 10% forfeiture fee. Additionally, the payment for early closure may take a minimum of 7 days to a maximum of 14 days to process, depending on the payment processors involved.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 12),
              Text(
                '2. Returns are credited daily to your Naira wallet. From there, you can choose to withdraw or use the funds for utility purchases, such as paying bills, data bundles, airtime top-ups, as soon as those options become available.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 12),
              Text(
                '3. Bonus Lotusgold (LGD) are credited to you immediately after your investment package is confirmed to begin.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 12),
              Text(
                '4. Investment returns are subject to market conditions and other factors beyond our control. While we strive to mitigate risks and protect capital, we cannot be held liable for losses arising from such conditions.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                'Project Details',
                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your investment is part of a larger project aimed at creating a stable and valuable asset backed by physical gold. Here’s how your funds are being utilized:',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '- Gold Reserves: A portion of the funds is used to acquire gold reserves, which back the value of Lotusgold (LGD).',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '- Platform Development: Investment in technology and security measures to ensure the integrity and safety of the Lotusgold platform.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '- Market Expansion: Efforts to integrate LGD into various economic activities, increasing its usability and demand.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '- Community Growth: Marketing and referral programs to expand the Lotusgold user base, enhancing the network’s value.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                'Project Stages',
                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'The Lotusgold project is divided into three stages:',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '1. Stage 1: Building gold reserves and securing initial investments. Early investors enjoy attractive returns and bonus LGD.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '2. Stage 2: Integration with merchants and expanding the ecosystem. LGD becomes redeemable, providing significant value to investors.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '3. Stage 3: Establishing partnerships with local companies and striving to acquire mining licenses to increase gold reserves. This is a continuous effort, not limited to just one phase, and partnerships are not restricted to any one sector of the economy. We can also partner in agriculture to foster stable food prices, among other sectors.',
                style: GoogleFonts.dmSans(fontSize: 14),
              ),
              SizedBox(height: 16),
              Text(
                'Future Redeemability and Value of LGD',
                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Lotusgold (LGD) is projected to become redeemable in the fourth quarter of Stage 2 of the project. At that point, LGD will be usable for withdrawals or for purchasing goods and services within the Lotusgold ecosystem. The potential value of LGD is significant, given the project\'s aim to back it with physical gold and the expected increase in demand as the ecosystem expands.',
                style: GoogleFonts.dmSans(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Example Value of LGD',
                style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              Text(
                'Assuming in the next 2 years or by the time the project reaches Stage 2, the value of 1 LGD is determined to be ₦5,000:',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 5),

              Text(
                'For the Starter Package, with a bonus of 2 LGD, the total bonus value would be ₦10,000.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'For the Bronze Package, with a bonus of 5 LGD, the total bonus value would be ₦25,000.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'For the Silver Package, with a bonus of 15 LGD, the total bonus value would be ₦75,000.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'For the Gold Package, with a bonus of 30 LGD, the total bonus value would be ₦150,000.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'For the Platinum Package, with a bonus of 60 LGD, the total bonus value would be ₦300,000.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
