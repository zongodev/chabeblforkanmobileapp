

import 'package:chabebalforqab/controller/judgingdashcontroller.dart';
import 'package:chabebalforqab/view/welcomepage/welcomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebaseconst.dart';

class AuthServices {
  DashController dashController = Get.find();
  static Future<void> signInUser(String email, String password, ctx) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text("الرجاء إدخال البريد الإلكتروني وكلمة المرور."),
          ),
        );
        return;
      }

      await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in successfully');
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("تم تسجيل الدخول بنجاح"),
        ),
      );

      Get.to(WelcomePage());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text("لا يوجد مستخدم بهذا البريد الإلكتروني."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text("كلمة المرور غير صحيحة."),
          ),
        );
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text("خطأ: حدثت مشكلة"),
          ),
        );
      }
    } catch (e) {
      print('Error during sign in: $e'); // Add this line
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("خطأ: حدثت مشكلة"),
        ),
      );
    }
  }
  static Future<void> signOut(ctx) async {
    await FirebaseAuth.instance.signOut();

   Get.offNamed("/login");

  }
  Future<void> getCurrentJudge() async {
    final currentUser = authInstance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('maitre')
        .doc(currentUser!.uid)
        .get();
    dashController.judgeName.value = "${userDoc['name'] + " " + userDoc['lastname']}";
    dashController.judgeUid.value = currentUser.uid;

    print(userDoc['name']);
  }


}