import 'dart:async';
import 'dart:developer';

import 'package:chabebalforqab/Models/judgeCategory.dart';
import 'package:chabebalforqab/controller/judgingdashcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashCard extends StatelessWidget {
  const DashCard({
    Key? key,
    required this.sub,
    required this.judgingCat, this.question,this.index,
  }) : super(key: key);

  final sub;
  final JudgingCat judgingCat;
  final String? question;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final dashController = Get.put(
      DashController(),
    );
    log("hedhi judgingcat${judgingCat.title}");
    log("azeerrty${question}");
    return SizedBox(
      width: dashController.cat.value == "الترتيل نظرا من المصحف"
          ? MediaQuery.of(context).size.width * 0.47
          : null,
      child: Card(
        surfaceTintColor: Colors.white,
        color: dashController.cat.value == "الترتيل نظرا من المصحف"
            ? Color(0xFF5a85ba)
            : Colors.white,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                surfaceTintColor: Colors.white,
                color: dashController.cat.value == "الترتيل نظرا من المصحف"
                    ? Color(0xffDBE2EF)
                    : Colors.white,
                elevation: 9,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  color: dashController.cat.value == "الترتيل نظرا من المصحف"
                      ? Colors.blue[800]
                      : Color(0xFF863ED5),
                  onPressed: () {
                    if(question=='التفسير'){
                      sub["init"] == 0
                          ? null
                          : dashController.retryTafsir(sub, judgingCat);
                    }
                    if (dashController.cat.value != "الترتيل نظرا من المصحف") {
                      sub["init"] == 0
                          ? null
                          : dashController.retry(sub, judgingCat);
                    } else {
                      sub["init"] == 0
                          ? null
                          : dashController.retryTartil(sub, judgingCat);
                    }
                  },
                  icon: const Icon(Icons.replay_sharp),
                  iconSize: 40,
                ),
              ),
              SizedBox(
                width: dashController.cat.value == "الترتيل نظرا من المصحف"
                    ? MediaQuery.of(context).size.width * 0.35
                    : null,
                child: InkWell(
                  onTap: () {
                    if (dashController.cat.value != "الترتيل نظرا من المصحف") {
                      if (question == 'التفسير') {
                        // Logic for التفسير
                        dashController.setCardClicked(sub, true);
                        Timer(const Duration(seconds: 3), () {
                          dashController.setCardClicked(sub, false);
                        });
                        if (sub["txt"] == 'صحيح' && sub["init"] == 1) return;
                        if (sub["txt"] == 'مرادف' && sub["init"] == 1) return;
                        if (sub["txt"] == 'خطأ' && sub["init"] == 1) return;
                        dashController.updatePointsTafsir(sub, judgingCat,index??0);
                      }else{
                      dashController.setCardClicked(sub, true);
                      print(sub["txt"]);
                      Timer(const Duration(seconds: 3), () {
                        dashController.setCardClicked(sub, false);
                      });
                      if (sub["txt"] == 'حسن' && sub["init"] == 2) return;
                      if (sub["txt"] == 'ممتاز' && sub["init"] == 2) return;
                      if (sub["txt"] == 'ضعيف' && sub["init"] == 1) return;
                      judgingCat.title["init"] == 0 &&
                              sub["txt"] != 'حسن' &&
                              sub['txt'] != 'ممتاز' && sub['txt'] != 'ضعيف'
                          ? null /*:sub["txt"]!= 'حسن' && sub['txt'] != 'ممتاز'&&sub['nbr']>judgingCat.title["init"]?null*/
                          : dashController.updatePoints(sub, judgingCat);
                      if (dashController.judgingCat[0].items[2]["init"] == 3 ||
                          dashController.judgingCat[0].title["init"] <= 0) {
                        dashController.nextPage(context, sub: sub,question: question);
                      }}
                    } else {
                      dashController.setCardClicked(sub, true);
                      print(sub["txt"]);
                      Timer(const Duration(seconds: 3), () {
                        dashController.setCardClicked(sub, false);
                      });

                      if (sub["txt"] == 'الإستهلال و الانتهاء' &&
                          sub["init"] == 4) return;
                      if (sub["txt"] == 'جمال الصوت' && sub["init"] == 8)
                        return;
                      if (sub["txt"] == 'الانتقال الصحيح' && sub["init"] == 6)
                        return;
                      if (sub["txt"] == 'خشوع التلاوة' && sub["init"] == 4)
                        return;
                      if (sub["txt"] == 'العرب و القفلات' && sub["init"] == 4)
                        return;
                      if (sub["txt"] == 'التحكم في النفس' && sub["init"] == 2)
                        return;
                      judgingCat.title["init"] == 0
                          ? null
                          : dashController.updatePointsTartil(sub, judgingCat);
                    }
                  },
                  child: GetBuilder<DashController>(builder: (controller) {
                    return Card(
                      surfaceTintColor: Colors.white,
                      color:
                          dashController.cat.value == "الترتيل نظرا من المصحف"
                              ? Color(0xffDBE2EF)
                              : Colors.white,
                      elevation: 9,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: sub["isCardClicked"] &&
                                      (sub["txt"] == "حسن" ||
                                          sub["txt"] == "ممتاز" || sub["txt"] == "صحيح" || sub["txt"] == "مرادف")
                                  ? Colors.green
                                  : sub["isCardClicked"]
                                      ? Colors.red
                                      : Colors.transparent,
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/str.png",
                                  //scale: 9,
                                  width: 70,
                                  color: dashController.cat.value ==
                                          "الترتيل نظرا من المصحف"
                                      ? Colors.blue[800]
                                      : Color(0xFF863ED5),
                                ),
                                Text(
                                  "${sub["init"]}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 25),
                            FittedBox(
                              child: Text(
                                "${sub["txt"]}",
                                style: TextStyle(
                                  color: dashController.cat.value ==
                                          "الترتيل نظرا من المصحف"
                                      ? Colors.blue[800]
                                      : Color(0xFF863ED5),
                                  fontSize: 25,
                                  fontFamily: 'Kufam',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
