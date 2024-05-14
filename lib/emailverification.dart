import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/verified.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final List<TextEditingController> controllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 255, 242),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 250, 255, 242),
              Color.fromRGBO(225, 249, 221, 1),
              Color.fromRGBO(244, 247, 216, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Email Verification',
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF3E3E3E),
                  fontFamily: 'Gilroy-Bold'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please enter the 5 digit code that was sent to your email address.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return Container(
                  width: 40,
                  height: 48,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: index.toString(),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: 14,
                    color: Color(0xFF3E3E3E),
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'If you don’t receive code '),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-Regular',
                        color: Color(0xFF7EE36D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: verifyAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7EE36D),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 75, vertical: 8),
                ),
                child: const Text('Verify and Proceed',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyAndProceed() async {
    final String verificationCode =
        controllers.map((controller) => controller.text).join('');
    final Uri uri = Uri.parse('http://192.168.209.80:8080/account/verify');
    final Map<String, String> data = {
      'email': 'example@example.com',
      'verificationCode': verificationCode,
    };

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerifiedPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Verification Failed'),
            content: const Text('Invalid verification code. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
