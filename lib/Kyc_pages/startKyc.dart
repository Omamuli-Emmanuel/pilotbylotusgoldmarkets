import 'dart:convert';

import 'package:Pilot/global_widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:google_fonts/google_fonts.dart';
import '../BottomNav/bottomNav.dart';
import '../global_widgets/custom_text_form_field.dart';

class StartKyc extends StatefulWidget {
  final Map<String, dynamic> user;
  const StartKyc({required this.user});

  @override
  State<StartKyc> createState() => _StartKycState();
}

class _StartKycState extends State<StartKyc> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  String? selectedIdentification;
  String? selectedCountry;
  List<String?> _selectedFilePaths = [null, null];

  bool isLoading = false;

  final List<String> identifications = [
    "Driver's Licence",
    "International Passport",
    "Voter's Card",
    "NIN"
  ];

  final List<String> countries = [
    "Nigeria",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Start KYC',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 15),
                buildFormSection(
                  'Full Name (as it appears in your ID documents)',
                  CustomTextFormField(
                    controller: fullnameController,
                    inputType: TextInputType.text,
                    hintText: "Enter your full name",
                  ),
                ),
                SizedBox(height: 15),
                buildFormSection(
                  'Phone Number (Must be valid)',
                  CustomTextFormField(
                    controller: phoneNumber,
                    inputType: TextInputType.number,
                    hintText: "Enter your phone number",
                  ),
                ),
                SizedBox(height: 15),
                buildFormSection(
                  'Means of identification:',
                  DropdownButtonFormField<String>(
                    value: selectedIdentification,
                    items: identifications.map((String identification) {
                      return DropdownMenuItem<String>(
                        value: identification,
                        child: Text(identification),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedIdentification = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    hint: Text('Select Means of Identification'),
                  ),
                ),
                SizedBox(height: 20),
                buildFormSection(
                  'Country of Residence:',
                  DropdownButtonFormField<String>(
                    value: selectedCountry,
                    items: countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCountry = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    hint: Text('Select Country of Residence'),
                  ),
                ),
                SizedBox(height: 10),
                buildFileUploadContainer(
                  'Recent image',
                  'Upload a recent image of yourself',
                  _selectedFilePaths[0], 0,
                ),
                SizedBox(height: 5),
                buildFileUploadContainer(
                  'Government Issued ID (International passport, NIN, Driver licence etc)',
                  'Upload Government ID',
                  _selectedFilePaths[1], 1,
                ),
                SizedBox(height: 15),
                CommonButton(
                  onPress: () {
                    uploadDocuments(context, widget.user["uniqueId"]);
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildFormSection(String label, Widget child) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF344054),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget buildFileUploadContainer(String title, String buttonText, String? filePath, int index) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => pickFile(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.upload_file, size: 40, color: Color(0xFF6366f1)),
                    SizedBox(height: 5),
                    Text(
                      buttonText,
                      style: TextStyle(color: Color(0xFF6366f1)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      filePath != null ? filePath.split('/').last : '(Max. 2MB)\nFile type: JPEG, PNG, PDF.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFilePaths[index] = result.files.first.path;
      });
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.roboto(
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

  Future<void> uploadDocuments(BuildContext context, String uniqueId) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/kyc-start';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    // Add the uniqueId as a field in the request
    request.fields['uniqueId'] = uniqueId;
    request.fields['fname'] = fullnameController.text;
    request.fields['phone'] = phoneNumber.text;
    request.fields['means'] = selectedIdentification!;
    request.fields['country'] = selectedCountry!;

    for (int i = 0; i < _selectedFilePaths.length; i++) {
      if (_selectedFilePaths[i] != null) {
        io.File file = io.File(_selectedFilePaths[i]!);
        String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
        var mimeTypeSplit = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            'document[$i]', // The key you expect in your Laravel request
            file.path,
            contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
          ),
        );
      }
    }

    request.headers.addAll({'Content-Type': 'multipart/form-data'});

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final responseData = jsonDecode(responseBody);

    print(responseBody);

    if (response.statusCode == 200) {
      // Handle successful response
      showSnackbar(context, "Kyc submitted successfully.");
      setState(() {
        isLoading = false;
      });
      final user = responseData["user"];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: user),
        ),
      );
    } else {
      final Map<String, dynamic> responseJson = jsonDecode(responseBody);
      showSnackbar(context, "Upload failed: ${responseJson['error']}");
      setState(() {
        isLoading = false;
      });
    }
  }
}
