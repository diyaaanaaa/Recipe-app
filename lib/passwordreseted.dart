import 'package:flutter/material.dart';
import 'package:recipe_app/loginpage.dart';

class PasswordResetedPage extends StatelessWidget {
  const PasswordResetedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Color(0xFF7EE36D),
            ),
            const SizedBox(height: 20),
            const Text(
              'Password updated! ',
              style: TextStyle(
                fontFamily: 'Gilroy-Bold',
                fontSize: 24,
                color: Color(0xFF3E3E3E),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your password  has been changed successfully.',
              style: TextStyle(
                fontFamily: 'Gilroy-Regular',
                fontSize: 16,
                color: Color(0xFF707070),
              ),
            ),
            const SizedBox(height: 30),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7EE36D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 75, vertical: 8)),
                  child: const Text('Verify and Proceed',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                )),
          ],
        ),
      ),
    );
  }
}
