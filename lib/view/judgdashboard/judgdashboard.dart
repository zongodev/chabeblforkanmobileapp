import 'package:chabebalforqab/categorylist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controller/judgingdashcontroller.dart';
import 'dashboard.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/judgingdashcontroller.dart';
import 'dashboard.dart';

class JudgeDashboard extends StatelessWidget {
  final String title;
  final String comCat;

  JudgeDashboard({super.key, required this.title, required this.comCat});
  final DashController controller = Get.find();

  int getQuestionCount(String category) {
    final categoryData = categories.firstWhere(
          (cat) => cat['cat'] == category,
      orElse: () => {'questions': []},
    );
    return (categoryData['questions'] as List).length;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.4,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/dashbg.png"),
                ),
              ),
            ),
            Positioned(
              child: buildHeader(context, title, controller.cat.value, comCat),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: GetBuilder<DashController>(
                builder: (controller) {
                  return PageView.builder(
                    controller: controller.pagecontroller,
                    itemCount: getQuestionCount(controller.cat.value),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      controller.pageIndex.value = index;
                      print("Current page index: ${controller.pageIndex.value}");
                      return Dashboard();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The buildHeader widget remains the same
Widget buildHeader(ctx, title, cat, comCat) {
  var size = MediaQuery.of(ctx).size;
  final dashController = Get.put(DashController());

  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/btnbg1.jpg"),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topRight,
            image: AssetImage("assets/images/btnimg.jpg"),
          ),
        ),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الصنف : $comCat",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.021,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                              () => Text(
                            "المحكم:${dashController.judgeName.value} ",
                            style: TextStyle(
                              color: const Color(0xff0c5279),
                              fontSize: size.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: const Color(0xFFd6b065),
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 200),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

