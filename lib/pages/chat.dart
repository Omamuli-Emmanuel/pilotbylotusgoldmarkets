import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Chat(),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live chat',
          style: TextStyle(color: Color(0xFF2F4A9A), fontSize: 24, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Color(0xFF2F4A9A),
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Tawk(
        directChatLink: 'https://tawk.to/chat/66927c0f32dca6db2caed8a3/1i2m398jh',
        visitor: TawkVisitor(
          name: 'Your Name',
          email: 'youremail@address.com',
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
