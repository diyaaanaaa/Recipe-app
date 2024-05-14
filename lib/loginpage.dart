import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:recipe_app/createaccount.dart';
import 'package:recipe_app/forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteNames {
  static const String homepage = 'homepage'; // Example route name
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool passwordVisible = true;
  bool wrongPasswordOrUserName = false;
  bool showButton = false;
  String errorMessage = '';

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const String url = 'http://192.168.209.80:8080/auth/login';
    // const String url = 'http://localhost:8080/auth/login';
    final Uri myUrl = Uri.parse(url);
    print(myUrl);
    try {
      final response = await http.post(
        myUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {"username": username.text, "password": password.text},
        ),
      );
      // print("hjj");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        prefs.setString('token', data['accessToken']);
        // prefs.setString('refreshToken', data['refreshToken']);
        final Map<String, dynamic> payload = Jwt.parseJwt(data['accessToken']);
        // prefs.setString('walletId', payload['userId'].toString());
        // prefs.setString('email', payload['email']);
        for (var i in payload['role']) {
          if (i != 'ROLE_CUSTOMER') {
            prefs.setString('role', i);
          }
        }
        Navigator.pushReplacementNamed(context, RouteNames.homepage);
      } else {
        setState(() {
          final err = json.decode(response.body);
          if (err['message'] == 'wrong_username_or_appid' ||
              err['message'] == 'wrong_password') {
            errorMessage = 'The username or password is incorrect';
            wrongPasswordOrUserName = true;
          } else {
            errorMessage = err['message'];
          }
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        errorMessage = 'An error occurred: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      minimum: EdgeInsets.zero,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 250, 255, 242),
                Color.fromRGBO(225, 249, 221, 1),
                Color.fromRGBO(244, 247, 216, 1)
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 20.0)),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 30.0, left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("LOGIN",
                                  style: TextStyle(
                                    color: Color(0xFF3E3E3E),
                                    fontFamily: 'Gilroy-Bold',
                                    fontSize: 40,
                                  )),
                              const SizedBox(height: 15),
                              usernameField(),
                              const SizedBox(height: 15),
                              passwordField(),
                              const SizedBox(height: 15),
                              if (wrongPasswordOrUserName)
                                Text(errorMessage,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(216, 69, 69, 1),
                                    )),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                const ForgotPassword(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Color(0xFF3E3E3E),
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30.0,
                        left: 30.0,
                      ),
                      child: Column(
                        children: [
                          raisedButton(),
                          const SizedBox(height: 20),
                          const Divider(
                            height: 5.0,
                            color: Color.fromRGBO(36, 34, 39, 0.5),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don’t have an account?",
                                  style: TextStyle(
                                    fontFamily: 'Giroy-Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF3E3E3E),
                                  )),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const CreateAccount(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: const Text("SIGN UP",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7EE36D),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Username",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Gilroy-Regular",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF707070),
            )),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: _onFieldChanged,
          controller: username,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username or Email is required.';
            }
            return null;
          },
          style: const TextStyle(
              color: Color(0xFF707070),
              fontSize: 18,
              fontFamily: 'Gilroy-Regular'),
          keyboardType: TextInputType.text,
          cursorColor: const Color(0xFF707070),
          cursorWidth: 1.5,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            hoverColor: Colors.transparent,
            hintText: 'Type your Username or Emai...',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF707070),
            ),
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(145, 144, 147, 0.7)),
              borderRadius: BorderRadius.all(Radius.circular(19.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(145, 144, 147, 0.7)),
              borderRadius: BorderRadius.all(Radius.circular(19.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(19)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(255, 12, 62, 1),
                )),
          ),
        ),
      ],
    );
  }

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF707070),
            )),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: _onFieldChanged,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          controller: password,
          obscureText: passwordVisible,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required.';
            }
            return null;
          },
          style: const TextStyle(
              color: Color(0xFF707070),
              fontSize: 18,
              fontFamily: 'Gilroy-Regular'),
          keyboardType: TextInputType.text,
          cursorColor: Color(0xFF707070),
          cursorWidth: 1.5,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              color: const Color(0xFF707070),
              iconSize: 23,
              icon: passwordVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            isDense: true,
            filled: true,
            hoverColor: Colors.transparent,
            hintText: 'Type your Password...',
            hintStyle: const TextStyle(
              fontFamily: 'Gilroy-Regular',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF707070),
            ),
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(145, 144, 147, 0.7)),
              borderRadius: BorderRadius.all(Radius.circular(19.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(145, 144, 147, 0.7)),
              borderRadius: BorderRadius.all(Radius.circular(19.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(19)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(255, 12, 62, 1),
                )),
          ),
        ),
      ],
    );
  }

  Widget raisedButton() {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7EE36D),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 8),
        ),
        onPressed: showButton ? login : null,
        child: const Text('LOGIN',
            style: TextStyle(fontSize: 15, fontFamily: 'Gilroy')),
      ),
    );
  }

  void _onFieldChanged(String value) {
    setState(() {
      errorMessage = '';
      showButton = username.text.isNotEmpty && password.text.isNotEmpty;
    });
  }
}
