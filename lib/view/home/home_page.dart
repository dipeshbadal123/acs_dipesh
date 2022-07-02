import 'package:advance_cyber_security/view/password/change_password.dart';
import 'package:advance_cyber_security/view/auth/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    GRecaptchaV3.ready("6LeiibMgAAAAAMfUwJLHpzaQ6EPAghJ6HhMi3-tZ",
        showBadge: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.cyan,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_qfuwimcl.json',
                  fit: BoxFit.fitWidth),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'User Account Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.cyan),
                          ),
                          Container(
                            height: 250,
                            child: ClipRRect(
                              child: Image.network(
                                  'https://static.vecteezy.com/system/resources/previews/002/318/271/original/user-profile-icon-free-vector.jpg'),
                            ),
                          ),
                          Text(FirebaseAuth.instance.currentUser.email
                              .toString()),
                          Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                color: Colors.cyan,
                                child: MaterialButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return ChangePassword();
                                      }));
                                    },
                                    child: Text(
                                      'CHANGE PASSWORD',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                color: Colors.cyan,
                                child: MaterialButton(
                                    onPressed: () async {
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      try {
                                        await auth.signOut().then((value) {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LoginPage();
                                          }));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(80.0),
                                                  padding: EdgeInsets.all(25),
                                                  duration:
                                                      Duration(seconds: 3),
                                                  shape:
                                                      RoundedRectangleBorder(),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'User account logged out successfully...')));
                                        });
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    },
                                    child: Text(
                                      'LOG OUT',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
