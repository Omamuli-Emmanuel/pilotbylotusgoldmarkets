import 'package:Pilot/global_widgets/common_button.dart';
import 'package:Pilot/pages/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class SupportPage extends StatelessWidget {
  final String facebookUrl = 'https://www.facebook.com/lotusgoldmarket';
  final String instagramUrl = 'https://www.instagram.com/lotusgoldmarket';
  final String twitterUrl = 'https://twitter.com/lotusgoldmarket';
  final String tiktokUrl = 'https://www.tiktok.com/@lotusgoldmarket';
  final String linkedinUrl = 'https://www.linkedin.com/company/lotusgold-market/?viewAsMember=true';
  final String whatsappUrl = 'https://wa.me/2349038942953';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('General Inquiries'),
              subtitle: Text('hello@lotusgoldmarkets.co', style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  _copyToClipboard(context, 'hello@lotusgoldmarkets.co');
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Technical Support'),
              subtitle: Text('support@lotusgoldmarkets.co', style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  _copyToClipboard(context, 'support@lotusgoldmarkets.co');
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Payment Disputes'),
              subtitle: Text('disputes@lotusgoldmarkets.co', style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  _copyToClipboard(context, 'disputes@lotusgoldmarkets.co');
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Partnership'),
              subtitle: Text('partners@lotusgoldmarkets.co', style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  _copyToClipboard(context, 'partners@lotusgoldmarkets.co');
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Social Media',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/socials/facebook.jpeg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _launchURL(facebookUrl);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/socials/instagram.png',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _launchURL(instagramUrl);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/socials/x.png',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _launchURL(twitterUrl);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/socials/tiktok.png',
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {
                    _launchURL(tiktokUrl);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/socials/linkedin.png',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    _launchURL(linkedinUrl);
                  },
                ),
              ],
            ),
            Spacer(),
            ListTile(
              leading: Image.asset("assets/socials/whatsapp.png", width: 50, height: 50,),
              title: Text('Message us on WhatsApp', style: TextStyle(fontSize: 15),),
              trailing: IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  _launchURL(whatsappUrl);
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.contact_support, size: 50, color: Color(0xFF3730a3),),
              title: Text('Live chat with one of our agents', style: TextStyle(fontSize: 15),),
              trailing: IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat()));
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
