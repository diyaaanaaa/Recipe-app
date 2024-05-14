import 'package:flutter/material.dart';
import 'package:recipe_app/passwordreseted.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 255, 242),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Reset Password',
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF3E3E3E),
                  fontFamily: 'Gilroy-Bold'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your new password must be different from previously used password',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy-regular',
                  color: Color(0xFF3E3E3E)),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'New password',
                  hintText: 'Type your New Password',
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: Color(0xFF707070)),
                  hintStyle: TextStyle(
                    color: Color(0xFFE7E7E7),
                    fontFamily: 'Gilroy-Regular',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  hintText: 'Confirm your password',
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: Color(0xFF707070)),
                  hintStyle: TextStyle(
                    color: Color(0xFFE7E7E7),
                    fontFamily: 'Gilroy-Regular',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 45),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordResetedPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7EE36D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 8)),
                child: const Text('Continue',
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
}
