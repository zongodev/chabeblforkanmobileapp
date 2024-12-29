import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/judgingdashcontroller.dart';

class DashboardCard extends StatelessWidget {
  final iconSrc;
  final Title;
  final Function() press;
  //final bool isDisabled;

  DashboardCard({
    Key? key,
    this.iconSrc,
    this.Title,
    required this.press,
    /*required this.isDisabled,*/
  });
  DashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return
       InkWell(
        onTap: controller.isDisabled.value ? null : press,
        child: Card(
          elevation: 9,
          shadowColor: Color(0xFFd6b065),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/btnbg1.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: controller.isDisabled.value
                    ? Container(
                  color: Colors.grey.withOpacity(0.4),
                )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back_ios_new_outlined),
                    Row(
                      children: [
                        Text(
                          Title,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Kufam",
                          ),
                        ),
                        iconSrc != null
                            ? Lottie.asset(
                          iconSrc,
                          //scale: scale,
                          //width: width,
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}
