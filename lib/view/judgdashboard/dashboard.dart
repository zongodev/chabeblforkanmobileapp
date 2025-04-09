import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chabebalforqab/categorylist.dart';
import 'package:chabebalforqab/view/judgdashboard/widgets/dashrow.dart';
import 'package:chabebalforqab/view/judgdashboard/widgets/titlesection.dart';
import '../../controller/judgingdashcontroller.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final DashController controller = Get.find();

  List<Map<String, dynamic>> getQuestions() {
    final categoryData = categories.firstWhere(
          (cat) => cat['cat'] == controller.cat.value,
      orElse: () => {'questions': []},
    );
    return List<Map<String, dynamic>>.from(categoryData['questions']);
  }

  void showConfirmationDialog(BuildContext context) {
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
        content: const Text(
          'هل ترغب في حفظ الامتحان؟',
          style: TextStyle(fontSize: 30),
          textDirection: TextDirection.rtl,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            onPressed: () => Get.back(),
            child: const Text(
              'لا',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Kufam",
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            onPressed: () {
              if (controller.cat.value == "الترتيل نظرا من المصحف") {
                controller.addTartilScore();
                controller.resetTartilData();
              } else {
                controller.addScore();
                controller.resetData();
              }
              Get.back();
              Get.back();
            },
            child: const Text(
              'نعم',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Kufam",
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool shouldShowConfirmation() {
    final questions = getQuestions();
    final currentIndex = controller.pageIndex.value;

    if (controller.cat.value == "الترتيل نظرا من المصحف") return true;
    if (["حفظ القرآن الكريم كاملا", "حفظ نصف القرآن"].contains(controller.cat.value)) {
      return currentIndex == questions.length - 1;
    }
    return currentIndex == questions.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    controller.changeBtnText();
    return controller.cat.value == "الترتيل نظرا من المصحف"
        ? buildColumnTartilCategory(context)
        : buildColumnAllCategory(context);
  }

  Widget buildNavigationButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool isBack = false,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      height: 50,
      elevation: 10,
      color: const Color(0xFFd6b065),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (isBack) Icon(icon),
          if (isBack) const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          if (!isBack) const SizedBox(width: 15),
          if (!isBack) Icon(icon),
        ],
      ),
    );
  }

  Column buildColumnAllCategory(BuildContext context) {
    final questions = getQuestions();
    bool isTafsirQuestion = questions[controller.pageIndex.value]["title"] == 'التفسير';
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: isTafsirQuestion?0:18, top:isTafsirQuestion?50: 28),
          child: Align(
            alignment: isTafsirQuestion? Alignment.center:Alignment.topRight,
            child: Text(
              isTafsirQuestion?"${questions[controller.pageIndex.value]["title"]}":"${questions[controller.pageIndex.value]["title"]} (${controller.pageIndex.value + 1})",
              style:  TextStyle(
                color: Colors.black,
                fontSize: isTafsirQuestion?70:28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: questions[controller.pageIndex.value]["title"]=='التفسير'?controller.judgingCatTafsir.length:controller.judgingCat.length,
            itemBuilder: (context, index) {
              final category = questions[controller.pageIndex.value]["title"]=='التفسير'?controller.judgingCatTafsir[index]:controller.judgingCat[index];
              log("azerty ${category.title}");
              return Column(
                children: [
                  isTafsirQuestion? SizedBox(height: 50,):SizedBox(),
                  SectionTitle(
                    title: category.title["title"],
                    score: category.title["init"],
                  ),
                  isTafsirQuestion? SizedBox(height: 20,):SizedBox(),
                  DashRow(
                    subcategories: category.items,
                    judgcat: category,
                    question : questions[controller.pageIndex.value]["title"],
                    index: index,
                  ),
                  //isTafsirQuestion? SizedBox(height: 20,):SizedBox(),
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
              if (controller.pageIndex.value == 0)
                buildNavigationButton(
                  onPressed: () => controller.previousPage(context),
                  text: "رجوع",
                  icon: Icons.arrow_back,
                  isBack: true,
                ),
              Obx(() => Text(
                isTafsirQuestion
                    ? "المجموع : ${controller.someTafsir.value}"
                    : "المجموع : ${controller.some.value}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              buildNavigationButton(
                onPressed: () {
                  if (controller.txt.value == "تسجيل الامتحان") {
                    if (controller.mofrada1NotSelected() || controller.mofrada2NotSelected()) {
                      controller.showMofradaConfirmation(context);
                      return; // Prevent further execution
                    }
                  } else if (controller.adaaNotSelected()) {
                    controller.showAdaaConfirmation(context);
                    return;
                  }

                  if (shouldShowConfirmation()) {
                    showConfirmationDialog(context);
                  } else {
                    controller.nextPage(context, question: questions[controller.pageIndex.value]["title"]);
                  }
                },

                text: controller.txt.value,
                icon: controller.txt.value == "تسجيل الامتحان"
                    ? Icons.save
                    : Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildColumnTartilCategory(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: controller.judgingCatTartil.length,
            itemBuilder: (context, index) {
              final category = controller.judgingCatTartil[index];
              return Column(
                children: [
                  SectionTitle(
                    title: category.title["title"],
                    score: category.title["init"],
                  ),
                  DashRow(
                    subcategories: category.items,
                    judgcat: category,
                    index: index,
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
              buildNavigationButton(
                onPressed: () => controller.previousPage(context),
                text: "رجوع",
                icon: Icons.arrow_back,
                isBack: true,
              ),
              Text(
                "المجموع : ${controller.tartilSome.value}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              buildNavigationButton(
                onPressed: () => showConfirmationDialog(context),
                text: controller.txt.value,
                icon: controller.txt.value == "تسجيل الامتحان"
                    ? Icons.save
                    : Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ],
    );
  }
}