import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0,left: 20),
      child: MaterialButton(
        onPressed: () {
          Get.back();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        height: 50,
        elevation: 10,
        color: const Color(0xFFd6b065),
        child: SizedBox(
          width: 100,
          child: Row(
            children: [



              Icon(Icons.arrow_back),
              const SizedBox(
                width: 15,
              ),
              Text(
                "رجوع",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}