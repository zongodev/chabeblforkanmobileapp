import 'dart:developer';

import 'package:chabebalforqab/categorylist.dart';
import 'package:chabebalforqab/view/judgdashboard/widgets/dashrow.dart';
import 'package:chabebalforqab/view/judgdashboard/widgets/titlesection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/judgingdashcontroller.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    super.key,
  });

  DashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var category;
    controller.changeBtnText();
    return controller.cat.value == "الترتيل نظرا من المصحف"
        ? buildColumnTartilCategory(category, context)
        : buildColumnAllCategory(category, context);
  }

  Column buildColumnAllCategory(category, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 18, top: 28),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              "${questions[controller.pageIndex.value]["title"]} (${controller.pageIndex.value + 1})",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                //fontFamily: 'Gulzar-Regular',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.judgingCat.length,
            itemBuilder: (context, index) {
              category = controller.judgingCat[index];
              log("${controller.judgingCat[index].title}");
              return Column(
                children: [
                  SectionTitle(
                    title: category.title["title"],
                    score: category.title["init"],
                  ),
                  DashRow(
                    subcategories: category.items,
                    judgcat: category,
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: controller.pageIndex == 0,
                replacement: Text(
                  "المجموع : ${controller.some.value}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                child: MaterialButton(
                  onPressed: () {
                    controller.previousPage(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  height: 50,
                  elevation: 10,
                  color: const Color(0xFFd6b065),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "رجوع",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              controller.pageIndex == 0
                  ? Text(
                      "المجموع : ${controller.some.value}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  : SizedBox(),
              MaterialButton(
                onPressed: () {
                  log("hedhi cat ${controller.cat.value}");
                  log("hedhiiiii${controller.pageIndex.value}");
                  log("${controller.pageIndex.value}");
                  if (controller.cat.value == "حفظ القرآن الكريم كاملا" &&
                      controller.pageIndex.value == questions.length-1 ) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                        surfaceTintColor: Colors.white,
                        title: const Text(
                          'هل أنت متأكد؟',
                          style: TextStyle(fontSize: 25),
                          textDirection: TextDirection.rtl,
                        ),
                        content: const Text('هل ترغب في حفظ الامتحان؟',
                            style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'لا',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () async {
                              controller.addScore();
                              Get.back();
                              controller.resetData();
                              Get.back();

                            },
                            child: const Text(
                              'نعم',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                        ],
                      ),
                    );

                  }
                  else if (controller.cat.value == "حفظ نصف القرآن" &&
                      controller.pageIndex.value == questions.length-2 ) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                        surfaceTintColor: Colors.white,
                        title: const Text(
                          'هل أنت متأكد؟',
                          style: TextStyle(fontSize: 25),
                          textDirection: TextDirection.rtl,
                        ),
                        content: const Text('هل ترغب في حفظ الامتحان؟',
                            style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'لا',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () async {
                              controller.addScore();
                              Get.back();
                              controller.resetData();
                              Get.back();

                            },
                            child: const Text(
                              'نعم',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (controller.cat.value !=
                          "حفظ القرآن الكريم كاملا" &&
                      controller.cat.value != "حفظ نصف القرآن" &&
                      controller.pageIndex.value == questions.length-2 ) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                        surfaceTintColor: Colors.white,
                        title: const Text(
                          'هل أنت متأكد؟',
                          style: TextStyle(fontSize: 25),
                          textDirection: TextDirection.rtl,
                        ),
                        content: const Text('هل ترغب في حفظ الامتحان؟',
                            style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'لا',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                            onPressed: () async {
                              controller.addScore();
                              Get.back();
                              controller.resetData();
                              Get.back();

                            },
                            child: const Text(
                              'نعم',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Kufam"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else {
                    controller.nextPage(context);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                height: 50,
                elevation: 10,
                color: const Color(0xFFd6b065),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      controller.txt.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(controller.txt.value == "تسجيل الامتحان"
                        ? Icons.save
                        : Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: 60,)
      ],
    );
  }

  Column buildColumnTartilCategory(category, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.judgingCatTartil.length,
            itemBuilder: (context, index) {
              category = controller.judgingCatTartil[index];
              log("${controller.judgingCat[index].title}");
              return Column(
                children: [
                  SectionTitle(
                    title: category.title["title"],
                    score: category.title["init"],
                  ),
                  DashRow(
                    subcategories: category.items,
                    judgcat: category,
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  controller.previousPage(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                height: 50,
                elevation: 10,
                color: const Color(0xFFd6b065),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "رجوع",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "المجموع : ${controller.tartilSome.value}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              MaterialButton(
                onPressed: () {
                  log("hedhi cat ${controller.cat.value}");
                  log("hedhiiiii${controller.pageIndex.value}");
                  log("${controller.pageIndex.value}");
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) => AlertDialog(
                      surfaceTintColor: Colors.white,
                      title: const Text(
                        'هل أنت متأكد؟',
                        style: TextStyle(fontSize: 25),
                        textDirection: TextDirection.rtl,
                      ),
                      content: const Text('هل ترغب في حفظ الامتحان؟',
                          style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'لا',
                            style: TextStyle(color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Kufam"),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
                          onPressed: () async {
                            controller.addTartilScore();
                            Get.back();
                            controller.resetTartilData();
                            Get.back();

                          },
                          child: const Text(
                            'نعم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Kufam"),
                          ),
                        ),
                      ],
                    ),
                  );

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                height: 50,
                elevation: 10,
                color: const Color(0xFFd6b065),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      controller.txt.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(controller.txt.value == "تسجيل الامتحان"
                        ? Icons.save
                        : Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: 60,)
      ],
    );
  }
}
