import 'package:advance_cyber_security/view/auth/authuntication.dart';
import 'package:advance_cyber_security/view/auth/login_view.dart';
import 'package:advance_cyber_security/view/home/home_page.dart';
import 'package:advance_cyber_security/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController {
  Future<User> logIn(String email, String password) async {
    EasyLoading.show();
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;

      EasyLoading.dismiss();

      return user;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      openDialog(e.message.toString());
    }
    return null;
  }

  Future<User> createAccount(String name, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    EasyLoading.show();
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      EasyLoading.dismiss();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "name": name,
        "email": email,
        "password":
            Crypt.sha256(password, rounds: 10000, salt: 'abcdefghijklmnop')
                .toString(),
      });
      return user;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      openDialog(e.message.toString());
    }
    return null;
  }

  Future<User> changePassword(
      String newPassword, String currentPassword) async {
    EasyLoading.show();
    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: FirebaseAuth.instance.currentUser.email.toString(),
          password: currentPassword);
      user.reauthenticateWithCredential(cred).then((value) {
        if (currentPassword == newPassword) {
          EasyLoading.dismiss();
          openDialog("Old password can not be new password");
        } else {
          user.updatePassword(newPassword).then((_) {
            EasyLoading.dismiss();

            Get.to(() => LoginPage());
            FirebaseAuth.instance.signOut();
            return openDialog("Password has been updated successfully");
          }).catchError((error) {
            EasyLoading.dismiss();
            openDialog(error.message.toString());
          });
        }
      }).catchError((err) {
        EasyLoading.dismiss();
        openDialog(err.message.toString());
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      openDialog(e.message.toString());
    }
    return null;
  }

  Future resetPassword(String email) async {
    EasyLoading.show();
    try {
      EasyLoading.dismiss();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.to(LoginPage());
      return openDialog(
          "Password reset link has been sent to the given user address");
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      openDialog(e.message.toString());
    }
  }
}
