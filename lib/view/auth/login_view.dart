// ignore_for_file: unused_field

import 'package:advance_cyber_security/view/auth/authuntication.dart';
import 'package:advance_cyber_security/view/password/forgot_password.dart';
import 'package:advance_cyber_security/view/auth/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool showPassword = true;
  bool isAgree = false;

  Future<User> logIn(String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Authunticate();
      }));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 2,
              right: MediaQuery.of(context).size.width * 0.3,
              left: MediaQuery.of(context).size.width * 0.3),
          padding: EdgeInsets.all(10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(),
          backgroundColor: Colors.red,
          content: Text('User Login successfull')));
      return user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 2,
              right: MediaQuery.of(context).size.width * 0.35,
              left: MediaQuery.of(context).size.width * 0.35),
          padding: EdgeInsets.all(15),
          action: SnackBarAction(
            textColor: Colors.red,
            label: 'CLOSE',
            onPressed: () {},
          ),
          duration: Duration(seconds: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          content: Text(
            e.message,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
          )));
// show the snackbar here
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_ozotlfrb.json',
                fit: BoxFit.cover),
          ),
          Container(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.35,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Login".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.blueAccent),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _email,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter a valid email!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                fillColor: Colors.white,
                                hintText: 'abc@gmail',
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              textDirection: TextDirection.ltr,
                              controller: _password,
                              obscureText: showPassword ? true : false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                  return 'Your Password needs to:\ninclude both lower and upper case character (A-Z or a-z)\ninclude at least one number(0-9) and symbol(@,£%^&*)\nbe at least 8 character long';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  value = _password.text;
                                });
                              },
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  suffixIcon: IconButton(
                                      icon: showPassword
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              color: Colors.white,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      }),
                                  hintText: 'P@ssw0rd',
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword()));
                                    },
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                color: Colors.deepOrange,
                                child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        logIn(_email.text.trim(),
                                            _password.text.trim());
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Checkbox(
                                  value: isAgree,
                                  onChanged: (e) {
                                    setState(() {
                                      isAgree = !isAgree;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: 1.0, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'I agree to the Terms and Conditions.   ',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      color: Colors.cyan,
                                      child: MaterialButton(
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return RegisterPage();
                                            }));
                                          },
                                          child: Text(
                                            'Register',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
