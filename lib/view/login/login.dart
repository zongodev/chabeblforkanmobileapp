import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/logincontroller.dart';
import 'widgets/background.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        size: size,
        child: Column(
          children: [
            SizedBox(height: size.height / 1.9),
            Center(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: "البريد الإلكتروني",
                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffe58d00)),
                          labelStyle: TextStyle(color: Color(0xffe58d00)),
                          suffixIcon: Icon(
                            Icons.email,
                            color: Color(0xffe58d00),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe58d00), width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe58d00), width: 2)),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.5,
                        child: TextFormField(
                          controller: controller.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            hintText: "كلمة المرور",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffe58d00)),
                            suffixIcon: Icon(
                              Icons.password,
                              color: Color(0xffe58d00),
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe58d00), width: 2)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe58d00), width: 2)),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
                        backgroundColor: const Color(0xff00447e),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Kufam",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => controller.signInJudge(),
                      child: Text("تسجيل الدخول",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
