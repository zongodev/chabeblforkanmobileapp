import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../categorylist.dart';
import '../../controller/compe=etitorcontroller.dart';
import '../../controller/judgingdashcontroller.dart';
import '../../shared/back_btn.dart';
import 'widgets/streambuilder.dart';

class Students extends StatelessWidget {
  Students({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;
  final CompetitorController competitorController =
      Get.put(CompetitorController());
  final DashController dashController =Get.put(DashController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return PopScope(
      canPop:   false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/dashbg.png"),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomCenter,
                  opacity: 0.4,
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: size.height * 0.3,
              child: Row(
                children: [
                  Obx(() => Text(
                    "عدد المتسابقين : ${competitorController.numberOfCompetitor.value}",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  )),
                 SizedBox(width: 40,),


                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * 0.39,
                ),
                StreamBuilderSpecific(
                  title: category[id]["title"],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: BackBtn(),
                ),
              ],
            ),
            Positioned(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/newbg.jpg",
                    fit: BoxFit.fill,
                    scale: 0.2,
                  ),
                  Positioned(
                    child: Text(
                      "${category[id]["title"]}",
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Color(0xFFd6b065),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Granada",
                        fontSize: 70,
                      ),
                    ),
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
