import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhitePaperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lotusgold Whitepaper',
          style: GoogleFonts.dmSans(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This Naira-backed platform introduces a revolutionary digital currency, Lotusgold, aimed at providing stability and preserving the value of money for users primarily in Nigeria, with aspirations to expand across Africa and beyond. The Lotusgold asset is provided and offered within the pilot app built by Lotusgold Markets as a company.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Market Analysis',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nigeria, like many other developing economies, faces significant challenges with currency devaluation and inflation. The Naira\'s value fluctuates widely against stronger currencies like the US Dollar, leading to economic uncertainty for individuals and businesses. Gold, on the other hand, has historically been a stable store of value, making it an ideal asset to back a digital currency designed to protect against inflation and currency devaluation.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Problem Statement',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The devaluation of the Naira erodes purchasing power, savings, and overall economic stability for Nigerians. This instability impacts daily transactions, savings, and long-term financial planning, making it difficult for individuals to preserve the value of their money. There is a pressing need for a solution that provides a reliable store of value and medium of exchange, immune to the volatile swings of fiat currency devaluation.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Solution',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Lotusgold Markets offers a stable digital currency backed by gold reserves, ensuring that its value remains relatively stable over time. Users can convert their Naira to Lotusgold, and vice versa, at any time. The value of Lotusgold is influenced by the market price of gold and the platform\'s internal supply and demand dynamics, creating a dual mechanism of stability and growth potential.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Technical Overview',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Lotusgold Markets is built on a secure and scalable architecture, ensuring seamless transactions and user interactions. Users can easily convert Naira to Lotusgold and back through a straightforward interface. The platform employs advanced security measures, including encryption and multi-factor authentication, to protect user data and funds. Compliance with local and international financial regulations is a cornerstone of the platform\'s operation, ensuring transparency and trust.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Business Model',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'To build the gold reserves necessary to back Lotusgold, the platform will offer investment packages to users. These packages will provide minor returns on investment, incentivizing early adopters to contribute to the growth of the gold reserves. As the reserves grow, the stability and credibility of Lotusgold will increase, attracting more users and merchants to the ecosystem. The platform will also integrate merchants, allowing them to accept Lotusgold for goods and services, further embedding the currency in daily economic activities.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Value of Lotusgold',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Lotusgold derives its value from a combination of factors designed to ensure stability and growth potential:',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Gold Backing:\n'
                  'Lotusgold is initially backed by physical gold reserves. Each unit of Lotusgold represents a corresponding value of gold, providing a foundational value that anchors its price.',
              style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Supply and Demand Dynamics:\n'
                  'The price of Lotusgold is also influenced by the dynamics of supply and demand within the Lotusgold Markets ecosystem. As more users convert Naira into Lotusgold, and as the ecosystem expands with merchant integration and transaction volume, the demand for Lotusgold can increase, potentially driving its price up.',
              style: GoogleFonts.dmSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Formula for Price Calculation:\n'
                  'The price of Lotusgold (Lg) can be determined using the following formula:\n'
                  'Lg = Total Gold Reserves (in NGN) / Total Lotusgold (Lg) in Circulation',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This formula calculates the price of Lotusgold based on the total amount of gold reserves backing the currency divided by the total amount of Lotusgold units in circulation within the platform. As the total gold reserves increase and the circulation of Lotusgold fluctuates with user transactions, the price of Lotusgold adjusts accordingly.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Example: Calculating the Initial Price of Lotusgold',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'To determine the price of Lotusgold, we would take into account the backing with physical gold and supply-demand dynamics, we need to start with the basic formula and then consider additional factors such as initial demand.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Current Market Data\n'
                  "Price of Gold: \$60 per gram (Approximate value)\n"
                  'Naira to Dollar Exchange Rate: ₦750 per \$1 (Approximate value, Feel free to use the current Naira to USD rate)',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Initial Assumptions\n'
                  'Total Gold Reserves: 10,000 grams of gold\n'
                  'Initial Total Lotusgold in Circulation: 5,000 units',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Initial Price Calculation Based on Gold Reserves\n'
                  'Convert Gold Price to Naira:\n'
                  'Price of Gold in Naira per gram = 60 USD/gram × 750 NGN/USD = 45,000 NGN/gram',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Calculate Initial Price of Lotusgold:\n'
                  'PG = Total Gold Reserves / Total Lotusgold in Circulation\n'
                  'PG = 10,000 grams / 5,000 units = 2 grams per unit\n'
                  'Convert to Naira:\n'
                  'Initial Value of 1 Lotusgold = 2 grams × 45,000 NGN/gram = 90,000 NGN',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Incorporating Supply and Demand Dynamics\n'
                  'For the initial price, we can use the calculated value. As the system evolves, the price may fluctuate based on the demand and supply within the ecosystem. Initially, the value of each Lotusgold unit is anchored to the physical gold reserve, providing a stable starting point.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Example in Context\n'
                  'If the current price of gold is \$60 per gram and the Naira to Dollar exchange rate is ₦750 per \$1:\n'
                  'Price of Gold in Naira per gram = 60 USD/gram × 750 NGN/USD = 45,000 NGN/gram\n'
                  'With a total of 10,000 grams of gold and 5,000 units of Lotusgold in circulation, the initial value of each unit of Lotusgold is:\n'
                  'Initial Value of 1 Lotusgold = 2 grams × 45,000 NGN/gram = 90,000 NGN\n'
                  'Thus, each unit of Lotusgold would initially be worth ₦90,000, subject to change based on future demand and supply dynamics within the ecosystem.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Addressing Regulatory and Strategic Considerations',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Regulatory Compliance\n'
                  'Lotusgold operates within the regulatory framework in Nigeria, where there are restrictions on cryptocurrencies like Bitcoin and Ethereum. By not operating on a blockchain and focusing on a gold-backed currency, Lotusgold aims to navigate this regulatory environment effectively. This approach ensures compliance while offering a stable financial alternative.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Strategic Focus on Stability and Economic Integration\n'
                  'Lotusgold is distinct from traditional cryptocurrencies like USDT or Bitcoin. It is a currency backed by physical gold reserves and influenced by supply and demand dynamics within its ecosystem. This model aims to provide stability and preserve the value of users’ assets amidst economic volatility.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Future Economic Integration with BRICS Ideology\n'
                  'Looking ahead, Lotusgold plans to align with the BRICS (Brazil, Russia, India, China, South Africa) ideology of economic collaboration. This involves establishing private gold reserves to underpin financial transactions and currency stability within the Lotusgold ecosystem. Similar to China and other BRICS nations, this approach seeks to enhance financial sovereignty and resilience.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Risk Management:',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Regulatory Compliance:\n'
                  'Given regulatory uncertainties, Lotusgold operates within current legal frameworks and monitors regulatory developments closely. Contingency plans include rapid response protocols to adapt to regulatory changes while maintaining user protection.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Government Intervention:\n'
                  'In the event of adverse government actions, such as shutdown threats or reclassification, Lotusgold will prioritize user safety and financial integrity. Assets will be liquidated promptly, and funds returned to users to mitigate any potential impact on their investments.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Future Partnership with Local Miners:\n'
                  'Lotusgold plans to establish partnerships with local miners in Nigeria and across Africa to bolster physical gold reserves. These partnerships are integral to expanding reserve sources and supporting economic inclusion. Plans include working towards obtaining a mining license to actively engage in gold mining operations, thereby securing additional reserves independently.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Development Stages of Lotusgold and User Benefits:',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Stage 1: Building Gold Reserves and Stability\n'
                  'During Stage 1, Lotusgold focuses on accumulating gold reserves and establishing stability within its ecosystem. Benefits to users include:\n'
                  'Increased Stability: As gold reserves grow, the stability of Lotusgold as a currency increases. This stability shields users from currency devaluation and inflation risks associated with fiat currencies like the Naira.\n'
                  'Value Preservation: Users benefit from the intrinsic value of gold backing Lotusgold, ensuring that their assets maintain their value over time.\n'
                  'Potential Growth: The initial growth in gold reserves may lead to gradual appreciation in the value of Lotusgold, providing early adopters with potential investment gains.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Stage 2: Integration of Economic Activities\n'
                  'In Stage 2, Lotusgold expands its economic footprint by integrating merchant transactions and enhancing user engagement. Benefits include:\n'
                  'Increased Utility: With merchants onboarded, users can actively use Lotusgold for transactions, expanding its utility beyond a store of value to a medium of exchange.\n'
                  'Market Demand: Expanded economic activities can drive up demand for Lotusgold, potentially increasing its value in response to market dynamics.\n'
                  'Economic Participation: Users benefit from enhanced economic participation, tapping into a growing ecosystem where Lotusgold serves as a stable and reliable currency.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Stage 3: Strengthening Security and Mining Integration\n'
                  'Stage 3 focuses on enhancing security measures and exploring opportunities for local mining integration. Benefits to users include:\n'
                  'Enhanced Security: Improved security protocols protect user assets and data, fostering trust and confidence in the platform.\n'
                  'Increased Reserves: Integration with local mining operations enhances gold reserves, further solidifying the value proposition of Lotusgold.\n'
                  'Long-term Stability: By securing mining licenses and expanding gold reserves, Lotusgold continues to offer a stable financial ecosystem, benefiting users seeking long-term value preservation.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Addressing Common Questions',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Q: How does Lotusgold provide a solution to the Naira\'s devaluation if the Naira is already pegged to the US dollar?',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Transitioning to an Independent Ecosystem: While it\'s true that the Naira\'s value is influenced by its exchange rate with the US dollar, Lotusgold offers several distinct advantages that create a more stable and independent financial ecosystem:\n'
                  'Supply and Demand Dynamics: Unlike fiat currencies, Lotusgold\'s value is also influenced by the internal supply and demand within the platform. As more users and merchants adopt Lotusgold for transactions, its value can appreciate based on the ecosystem\'s growth and activity. This creates a dual mechanism for value stability and potential appreciation.\n'
                  'Economic Shielding: By converting Naira to Lotusgold, users can shield their wealth from the immediate impacts of Naira devaluation. As the platform grows, the dependency on the initial inflow of Naira decreases. Instead, Lotusgold transactions can become self-sustaining, supported by a robust ecosystem of users and merchants who prefer to transact in a stable, gold-backed currency.\n'
                  'Long-Term Vision: The goal is to build an ecosystem where Lotusgold becomes a preferred medium of exchange and store of value, reducing the reliance on any single fiat currency. As the platform matures and the gold reserves grow, Lotusgold can offer a more resilient financial alternative that isn\'t directly tied to the fluctuations of the Naira or the US dollar.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Q: What separates Lotusgold from being an everyday Ponzi scheme?', style: GoogleFonts.dmSans(
                fontSize: 15,
              fontWeight: FontWeight.w500
            ),
            ),
            SizedBox(height: 8),
            Text(
              'Transparency and Sustainability: Lotusgold is fundamentally different from a Ponzi scheme in several key ways:\n'
                  'Asset-Backed Value: Unlike Ponzi schemes that rely solely on new investor money to pay returns, Lotusgold is backed by physical gold reserves. This tangible asset provides a real basis for the currency\'s value, ensuring that it is not dependent on a constant influx of new investors.\n'
                  'Regulatory Compliance: Lotusgold is committed to full regulatory compliance, adhering to financial regulations to ensure transparency and legality. This commitment to legal standards helps protect users and maintain the platform’s integrity.\n'
                  'Sustainable Business Model: The platform\'s business model is designed for long-term sustainability. While initial investments help build gold reserves, the ecosystem’s growth through merchant integration and user transactions generates continuous value. This value creation ensures that the system can support returns without relying on unsustainable practices.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Q: How does Lotusgold aim to build the capital base and maintain the investment system?',  style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w500
            ),
            ),
            SizedBox(height: 8),
            Text(
              'Diversified Income Streams and Strategic Planning: Lotusgold employs a multi-faceted approach to ensure a stable capital base and maintain the investment system:\n'
                  'Investment Packages: Initial capital is raised through carefully structured investment packages that offer competitive returns. These packages are designed to attract early adopters and build the necessary gold reserves to back Lotusgold.\n'
                  'Transaction Fees: The platform will generate revenue through small transaction fees on conversions and transactions within the ecosystem. These fees provide a steady income stream that supports platform operations and investment returns.\n'
                  'Merchant Partnerships: As more merchants join the platform, Lotusgold will facilitate transactions within the ecosystem, increasing the currency\'s utility and value. Merchant fees and strategic partnerships will contribute additional revenue.\n'
                  'Gold Reserve Management: A portion of the platform’s earnings will be reinvested into growing and maintaining the gold reserves. This continuous reinforcement of the reserves helps stabilize Lotusgold’s value and ensures the platform’s financial health.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Q: How does Lotusgold manage withdrawals and investment returns without affecting the currency’s stability?',  style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w500
            ),
            ),
            SizedBox(height: 8),
            Text(
              'Structured Withdrawal System: To maintain stability while honoring investment returns, Lotusgold employs a strategic approach to withdrawals:\n'
                  'Staggered Withdrawal Plans: Investments are structured with staggered withdrawal plans to prevent large, sudden outflows of capital. Investors may be offered extensions on their investment tenure with added profit incentives, encouraging longer-term investments.\n'
                  'Liquidity Management: The platform maintains a portion of the reserves in highly liquid assets to ensure it can meet withdrawal demands without destabilizing Lotusgold’s value.\n'
                  'Automated Adjustment Mechanisms: Advanced algorithms monitor and adjust the supply of Lotusgold in response to market conditions, ensuring that supply and demand remain balanced even as users withdraw funds.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Q: How does Lotusgold benefit low, medium, and high-income earners in Nigeria and beyond?',  style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w500
            ),
            ),
            SizedBox(height: 8),
            Text(
              'Lotusgold is designed to benefit a wide range of individuals, regardless of their income level:\n'
                  'Preservation of Purchasing Power: For low and medium-income earners, Lotusgold provides a stable store of value that helps preserve the purchasing power of their earnings. By converting Naira into Lotusgold, individuals can shield their savings from the impacts of currency devaluation and inflation, ensuring their money retains its value over time.\n'
                  'Access to Financial Stability: Lotusgold offers an accessible means for individuals to participate in a stable financial ecosystem traditionally dominated by higher-income brackets. It allows users to engage in transactions and savings with confidence, knowing that their wealth is secured by gold-backed value.\n'
                  'Opportunities for Growth: High-income earners and investors also benefit from Lotusgold’s potential for growth and value appreciation. As the ecosystem expands and demand for Lotusgold increases, early adopters can capitalize on investment opportunities and diversify their portfolios beyond traditional assets.\n'
                  'Economic Empowerment: By integrating with merchants and facilitating transactions within the ecosystem, Lotusgold creates economic opportunities for businesses and individuals alike. This integration fosters economic empowerment by promoting financial inclusion and expanding access to stable financial instruments.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Community Management:',
              style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Lotusgold values community engagement as integral to its success. Through transparent communication, regular updates, and a user-friendly interface, Lotusgold aims to foster trust and active participation among its users. Community feedback will be solicited and incorporated into platform improvements, ensuring that user needs and concerns are addressed promptly.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Text(
              'In conclusion, Lotusgold represents a groundbreaking solution to the challenges faced by economies like Nigeria, where currency devaluation and inflation threaten financial stability. By introducing a digital currency backed by physical gold reserves, Lotusgold offers users a reliable store of value and a medium of exchange immune to the volatile fluctuations of fiat currencies.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Throughout this whitepaper, we have explored the foundational principles, technical aspects, and strategic vision behind Lotusgold. From its inception as a stable alternative to traditional currencies to its integration with economic activities and commitment to regulatory compliance, Lotusgold is poised to revolutionize the financial landscape in Nigeria and beyond.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'As Lotusgold progresses through its development stages, users can expect increased stability, utility, and security. From building gold reserves to strengthening security measures and fostering economic integration, each stage is meticulously designed to enhance user benefits and ensure the long-term viability of the platform.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'With a clear focus on preserving the value of users\' assets and empowering economic participation, Lotusgold is not just a digital currency; it is a catalyst for financial empowerment and resilience. By embracing the BRICS ideology of economic collaboration and leveraging partnerships with local miners, Lotusgold aims to establish itself as a cornerstone of stability and prosperity in the evolving digital economy.',
              style: GoogleFonts.dmSans(
                  fontSize: 15
              ),
            ),
            SizedBox(height: 8),
            Text(
              'As we embark on this journey towards financial sovereignty and resilience, we invite you to join us in shaping the future of finance with Lotusgold. Together, we can build a more inclusive, transparent, and prosperous financial ecosystem that empowers individuals and strengthens communities.',
              style: GoogleFonts.dmSans(
                fontSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}

