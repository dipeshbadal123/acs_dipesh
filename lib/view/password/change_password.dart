import 'package:advance_cyber_security/view/auth/login_view.dart';
import 'package:advance_cyber_security/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    Future<User> changePassword() async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: 'a@gmail.com',
            password: _currentPasswordController.text.trim());
        user.reauthenticateWithCredential(cred).then((value) {
          user.updatePassword(_newPasswordController.text).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(80.0),
                padding: EdgeInsets.all(25),
                duration: Duration(seconds: 3),
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.red,
                content: Text('Password changed successfully')));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
            return user;
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(80.0),
                padding: EdgeInsets.all(25),
                duration: Duration(seconds: 3),
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.red,
                content: Text(error.message)));
          });
        }).catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(80.0),
              padding: EdgeInsets.all(25),
              duration: Duration(seconds: 3),
              shape: RoundedRectangleBorder(),
              backgroundColor: Colors.red,
              content: Text(err.message)));
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(80.0),
            padding: EdgeInsets.all(25),
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.red,
            content: Text(e.message)));

// show the snackbar here
      }
      return null;
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
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
            width: MediaQuery.of(context).size.width * 0.35,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Change Password".toUpperCase(),
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
                          textDirection: TextDirection.ltr,
                          controller: _currentPasswordController,
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
                              labelText: 'Current Password',
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
                          controller: _newPasswordController,
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
                              labelText: 'New Password',
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
                          controller: _confirmPasswordController,
                          obscureText: showPassword ? true : false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (_newPasswordController.text !=
                                _confirmPasswordController.text) {
                              return "Password didn't match";
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
                        padding: const EdgeInsets.all(18),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                changePassword();
                              }
                            },
                            child: const Text(
                              'Change Password',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
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
                              "OR",
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
                                          return HomePage();
                                        }));
                                      },
                                      child: Text(
                                        'Go Back',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )),
                                ))
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
