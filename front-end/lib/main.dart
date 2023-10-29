import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getReply(String question) async {
    try {
      final res = await http.post(
          headers: {"Content-Type": "application/json"},
          Uri.parse("http://10.0.2.2:8080/generateText"),
          body: jsonEncode({"prompt": question}));
      if (res.statusCode == 200) {
        dynamic resp = jsonDecode(res.body);
        print(resp);
        return resp["output"]["result"];
      } else {
        return "There was an error";
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  final List<types.Message> _messages = [];
  final _user1 = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _user2 = const types.User(id: '72091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(
            "Medi Buddy !!",
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.normal),
          ),
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user1,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    print(message);
  }

  void addLoadMessage() {
    final textMessage2 = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: "Loading ....",
    );
    _addMessage(textMessage2);
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user1,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    _addMessage(textMessage);

    String response = await getReply(message.text);
    final textMessage2 = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: response,
    );

    _addMessage(textMessage2);
  }

  void removeLoadMessage() {
    _messages.removeLast();
  }
}
