import 'package:advance_cyber_security/controller/auth_controller.dart';
import 'package:advance_cyber_security/services/recaptcha_services.dart';
import 'package:advance_cyber_security/view/auth/login_view.dart';
import 'package:advance_cyber_security/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool showPassword = true;
  bool isAgree = false;

  void initState() {
    super.initState();
    showCaptcha();
  }

  showCaptcha() async {
    await GRecaptchaV3.ready("6LeiibMgAAAAAMfUwJLHpzaQ6EPAghJ6HhMi3-tZ",
        showBadge: true);
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
          Center(
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
                          "Register".toUpperCase(),
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
                            controller: _name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty || value.length < 2) {
                                return 'Enter a valid username!';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
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
                              hintText: 'username',
                              labelText: 'User name',
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
                                  borderSide: BorderSide(color: Colors.white)),
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
                              if (value == 'P@ssw0rd') {
                                return "This is a commonly used password and can't b used";
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
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            textDirection: TextDirection.ltr,
                            controller: _confirmPassword,
                            obscureText: showPassword ? true : false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Confirm Password can't be empty";
                              }
                              if (_password.text != _confirmPassword.text) {
                                return "Your Password didn't match";
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
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: FlutterPasswordStrength(
                              password: _password.text,
                              backgroundColor: Colors.grey,
                              strengthCallback: (strength) {
                                debugPrint(strength.toString());
                              }),
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
                                      bool _isNotABot =
                                          await RecaptchaService.isNotABot();
                                      if (_isNotABot) {
                                        _formKey.currentState.save();
                                        AuthController()
                                            .createAccount(
                                                _name.text.trim(),
                                                _email.text.trim(),
                                                _password.text.trim())
                                            .then((value) => {
                                                  if (value != null)
                                                    {
                                                      Get.to(() => LoginPage()),
                                                      openDialog(
                                                          "User account registered Successfully")
                                                    }
                                                });
                                      } else {
                                        openDialog(
                                            "It seems that You are not human.");
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Register',
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
                                "Already have an account ?",
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
                                            return LoginPage();
                                          }));
                                        },
                                        child: Text(
                                          'LOGIN',
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
        ],
      ),
    );
  }
}
