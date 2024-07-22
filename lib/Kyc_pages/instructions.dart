import 'package:Pilot/Kyc_pages/startKyc.dart';
import 'package:Pilot/global_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KYCInstructions extends StatefulWidget {
  final Map<String, dynamic> user;
  const KYCInstructions({required this.user});

  @override
  State<KYCInstructions> createState() => _KYCInstructionsState();
}

class _KYCInstructionsState extends State<KYCInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC Submission Instructions',
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
                'Thank you for choosing to verify your identity with us. To ensure the security and compliance of our platform, we require some information from you. Please follow these steps carefully to complete the KYC process:',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Step 1: Prepare Required Documents',
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '• Recent Image: A clear, recent photograph of yourself, preferably taken within the last three months.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Legal Name: Your full legal name, as it appears on your official identification documents.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Country of Residence: The country where you currently reside.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Working Phone Number: A valid phone number where you can be reached for verification purposes.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Government-Issued Identity Card: Scan or photograph of your government-issued identity document (e.g., passport, driver\'s license, national ID card). Make sure the document is valid and not expired.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Step 2: Uploading Documents',
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Once you have all the required documents ready, proceed to upload them securely through our platform.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Step 3: Review and Submit',
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Before submitting your KYC information, take a moment to review all the details you\'ve provided. Ensure accuracy and completeness of the information and documents.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Step 4: Verification Process',
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Once you\'ve submitted your KYC information, our team will review it promptly. This process may take some time, so we appreciate your patience. We may contact you for further verification if needed.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Important Notes:',
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '• Ensure all uploaded documents are valid, clear, and unaltered.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Double-check the accuracy of the information provided before submission.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• Keep your phone nearby, as we may reach out to you for verification purposes.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              Text(
                '• If you encounter any issues during the submission process, please contact our support team for assistance.',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              SizedBox(height: 30,),
              CommonButton(
                onPress: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartKyc(user: widget.user)));
                },
                text: "Start Kyc",
              )
            ],
          ),
        ),
      ),
    );
  }
}
