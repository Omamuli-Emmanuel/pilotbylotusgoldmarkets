import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../payment_pages/failed.dart';
import '../payment_pages/successful.dart';

class PaymentWebview extends StatefulWidget {
  final Map<String, dynamic> user;
  final String amount;

  const PaymentWebview({required this.user, required this.amount});

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  late WebViewController _controller;
  late String transactionRef;
  final String baseUrl = 'https://kola.vpay.africa'; // Replace with your base URL
  final String publicKey = '5d81ca5b-5219-4343-b213-d71a147910b0'; // Replace with your public key
  final staticAuth = "base64:S4DkEB+PzxjzH7YmbUr20s4tWk3Idc4k/eLVyaopwyM=";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    }
    transactionRef = generateTransactionRef();
    pollWebhook(transactionRef); // Start polling the webhook
  }

  @override
  void dispose() {
    super.dispose();
  }

  String generateTransactionRef() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomString = String.fromCharCodes(
      List.generate(5, (index) => random.nextInt(26) + 65), // A-Z characters
    );
    return 'TXN-$timestamp-$randomString';
  }

  String createPayloadUrl() {
    final uri = Uri(
      scheme: 'https',
      host: 'dropinbutton-sandbox.vpay.africa',
      path: 'service/pay',
      queryParameters: {
        "amount": widget.amount,
        "email": widget.user["email"],
        "customer_logo": "https://yourdomain.com/yourbusinesslogo",
        "domain": "sandbox",
        "key": publicKey,
        "transactionref": transactionRef,
        "customer_service_channel": "support@vpay.africa,+2348191000800",
        "txn_charge_type": "percentage",
        "txn_charge": "2",
        "currency": "NGN",
      },
    );
    return uri.toString();
  }

  Future<void> pollWebhook(String transactionRef) async {
    final webhookUrl = 'https://lotusgoldmarkets.co/api/webhook/pull-transaction-status/$transactionRef'; // Use final for dynamically constructed URLs
    bool transactionStatus = true; // Define a boolean variable to control the loop

    while (transactionStatus) {
      await Future.delayed(Duration(seconds: 2)); // Poll every 10 seconds
      try {
        final response = await http.get(
          Uri.parse(webhookUrl),
          headers: {
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == "Success") {
            // Handle success - navigate to the Successful page
            transactionStatus = false; // Set the variable to false to break the loop
            creditUser();
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Successful(user: widget.user)));
          } else {
            print("No data received");
          }
        } else {
          final data = jsonDecode(response.body);
          // Handle failure - navigate to the Failed page
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Failed(user: widget.user)));
          print("Error: $data");
        }
      } catch (e) {
        // Handle error silently
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: WebView(
                initialUrl: createPayloadUrl(),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                onPageFinished: (String url) {
                  print("Page finished loading: $url");
                  // You can check the URL here and handle specific actions if needed
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> creditUser() async {
    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/credit-user';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'uniqueId': widget.user["uniqueId"],
        'email': widget.user["email"],
        'amount': widget.amount,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': generateTransactionRef(),
        'staticAuth': staticAuth,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if(responseData["status"] == "Success"){
        final user = responseData['user'];

        // Navigate to Successful page and pass the user object
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Successful(user: user)));
      }
    } else {
      final responseData = jsonDecode(response.body);
      print(responseData);
      // Navigate to Failed page and pass the user object
      Navigator.pushNamed(context, '/failed', arguments: widget.user);
    }
  }
}
