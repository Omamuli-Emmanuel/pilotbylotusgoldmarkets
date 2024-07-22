import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';

import '../BottomNav/bottomNav.dart';

class ProfilePicture extends StatefulWidget {
  final Map<String, dynamic> user;
  const ProfilePicture({required this.user});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _image;
  bool _isLoading = false;  // Loading state

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(File imageFile, String uniqueId) async {
    final String url = 'https://www.lotusgoldmarkets.co/api/upload-image'; // Replace with your API endpoint
    final request = http.MultipartRequest('POST', Uri.parse(url));

    print('Preparing to upload image for user with uniqueId: $uniqueId');

    // Add uniqueId field
    request.fields['uniqueId'] = uniqueId;

    // Determine the mime type of the selected file
    final mimeTypeData = lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    print('Mime type of the image: ${mimeTypeData![0]}/${mimeTypeData[1]}');

    // Attach the file in multipart request
    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_picture',
        imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ),
    );

    try {
      print('Sending request to $url');
      setState(() {
        _isLoading = true;  // Start loading
      });

      final response = await request.send().timeout(const Duration(seconds: 30));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        print('Response data: $responseData');

        final user = responseData["user"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(user: user),
          ),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        print('Failed to upload image. Status code: ${responseData}');
      }
    } catch (e) {
      if (e is TimeoutException) {
        showSnackbar(context, "Request timeout : Check Internet connection.");
        print(e.toString());
      } else {
        print('Error during image upload: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;  // Stop loading
      });
    }
  }

  void _handleUploadImage() {
    if (_image != null) {
      _uploadImage(_image!, widget.user['uniqueId']);
    }else{
      print("No image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Display Picture',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()  // Show loading indicator if loading
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null ? Icon(Icons.person, size: 60) : null,
            ),
            const SizedBox(height: 20),
            if (_image == null)
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Profile Picture'),
              )
            else ...[
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Another Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _handleUploadImage,
                child: const Text('Upload Profile Picture'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.cancel_outlined, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),)
        ],
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
