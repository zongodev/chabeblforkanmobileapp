import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebaseconst.dart';
import '../view/welcomepage/welcomepage.dart';

class LoginController extends GetxController {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  get email => _emailController;
  get password => _passwordController;

  //final RxBool isLoading = false.obs;

   Future<void> signInJudge() async {
    try {
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        Get.snackbar(
          "الرجاء إدخال البريد الإلكتروني وكلمة المرور.","الرجاء إدخال البريد الإلكتروني وكلمة المرور.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );

        return;
      }

      await authInstance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      print('User signed in successfully');
      Get.snackbar(
        "تم تسجيل الدخول بنجاح.","تم تسجيل الدخول بنجاح.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      _emailController.clear();
      _passwordController.clear();

      Get.offAll(WelcomePage());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "لا يوجد مستخدم بهذا البريد الإلكتروني.","لا يوجد مستخدم بهذا البريد الإلكتروني.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );

      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "كلمة المرور غير صحيحة.","كلمة المرور غير صحيحة.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );

      } else {
        Get.snackbar(
          "خطأ: حدثت مشكلة","خطأ: حدثت مشكلة",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );

      }
    } catch (e) {
      print('Error during sign in: $e');
      Get.snackbar(
        "خطأ: حدثت مشكلة","خطأ: حدثت مشكلة",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
