import 'dart:developer';


import 'package:chabebalforqab/consts/firebaseconst.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/judgeCategory.dart';
import 'package:chabebalforqab/categorylist.dart';

class DashController extends GetxController {
  late final PageController _pagecontroller;


  // CollectionReference note = FirebaseFirestore.instance.collection('note');
  RxDouble some = 18.0.obs;
  RxDouble someTafsir = 0.0.obs;
  RxDouble pointremoved = 0.0.obs;
  RxDouble pointremovedtartil = 0.0.obs;
  RxBool isLastOne=false.obs;
  RxBool isLastOneTartil=false.obs;
  RxBool isAdaaSelected=false.obs;
  RxDouble tartilSome = 20.0.obs;
   RxDouble total = 0.0.obs;
  RxString judgeName = "".obs;
  RxString judgeUid = "".obs;
  RxString catID = "".obs;
  RxString cat = "".obs;
   RxString CompetitorID = "".obs;
  RxInt pageIndex = 0.obs;
  RxBool isDisabled = false.obs;
  RxBool isLastClick = false.obs;
  RxString txt = "التالي".obs;
  List q = [];

  Map<String, double> allScores = {};

  PageController get pagecontroller => _pagecontroller;
  void getQuestionList(String category) {
    final categoryData = categories.firstWhere(
          (cate) => cate['cat'] == category,
      orElse: () => {'questions': []},
    );
    q= categoryData['questions'];
  }
  final RxList<JudgingCat> judgingCat = [
    JudgingCat(
      {"title": 'الحفظ', "init": 12},
      [
        {"txt": 'تلعثم', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'تنبيه', "nbr": 1, "init": 0, "isCardClicked": false},
        {"txt": 'فتح', "nbr": 2, "init": 0, "isCardClicked": false},
      ],
    ),
    JudgingCat(
      {"title": 'الوقف والابتداء', "init": 2},
      [
        {"txt": 'الوقف والابتداء', "nbr": 1, "init": 0, "isCardClicked": false},
      ],
    ),
    JudgingCat(
      {"title": 'التجويد', "init": 4},
      [
        {"txt": 'لحن خفي', "nbr": 0.25, "init": 0, "isCardClicked": false},
        {"txt": 'لحن جلي', "nbr": 1, "init": 0, "isCardClicked": false},
      ],
    ),
    JudgingCat(
      {"title": 'الأداء', "init": 0},
      [
        {"txt": 'ضعيف', "nbr": 0, "init": 0, "isCardClicked": false},
        {"txt": 'حسن', "nbr": 1, "init": 0, "isCardClicked": false},
        {"txt": 'ممتاز', "nbr": 2, "init": 0, "isCardClicked": false},
      ],
    ),
  ].obs;
  final RxList<JudgingCat> judgingCatTartil = [
    JudgingCat(
      {"title": 'معايير الصوت', "init": 14},
      [
        {"txt": 'الإستهلال و الانتهاء', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'جمال الصوت', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'الانتقال الصحيح', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'خشوع التلاوة', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'العرب و القفلات', "nbr": 0.5, "init": 0, "isCardClicked": false},
        {"txt": 'التحكم في النفس', "nbr": 0.5, "init": 0, "isCardClicked": false},

      ],
    ),
    JudgingCat(
      {"title": 'الوقف والابتداء', "init": 2},
      [
        {"txt": 'الوقف والابتداء', "nbr": 1, "init": 0, "isCardClicked": false},
      ],
    ),
    JudgingCat(
      {"title": 'التجويد', "init": 4},
      [
        {"txt": 'لحن خفي', "nbr": 0.25, "init": 0, "isCardClicked": false},
        {"txt": 'لحن جلي', "nbr": 1, "init": 0, "isCardClicked": false},
      ],
    ),

  ].obs;
  final RxList<JudgingCat> judgingCatTafsir = [
    JudgingCat(
      {"title": 'مفردة 1', "init": 0},
      [
        {"txt": 'صحيح', "nbr": 2, "init": 0, "isCardClicked": false},
        {"txt": 'مرادف', "nbr": 1, "init": 0, "isCardClicked": false},
        {"txt": 'خطأ', "nbr": 0, "init": 0, "isCardClicked": false},
      ],
    ),
    JudgingCat(
      {"title": 'مفردة 2', "init": 0},
      [
        {"txt": 'صحيح', "nbr": 2, "init": 0, "isCardClicked": false},
        {"txt": 'مرادف', "nbr": 1, "init": 0, "isCardClicked": false},
        {"txt": 'خطأ', "nbr": 0, "init": 0, "isCardClicked": false},
      ],
    ),
  ].obs;

  Map<String, double> initialTitleInitValues = {
    "الحفظ": 12,
    "الوقف والابتداء": 2,
    "التجويد": 4,
    "الأداء": 0,
  };
  Map<String, double> initialTitleInitValuesTartil = {
    "معايير الصوت": 14,
    "الوقف والابتداء": 2,
    "التجويد": 4,

  };
  Map<String, double> initialTitleInitValuesTafsir = {
    "مفردة 1": 0,
    "مفردة 2": 0,
  };

  void updatePoints(Map<String, dynamic> item, JudgingCat judgCat) {
    double pointsToAdd = item['nbr'].toDouble();
    item['init'] += 1;
    print("hedhi init ${item['init']}");

    // Logic for حسن
    if (item['txt'] == 'حسن') {
      isAdaaSelected.value=true;
      judgCat.title["init"] = item["nbr"];
      some.value += pointsToAdd;

      // Remove points from ممتاز if already selected
      if (judgingCat[3].items[2]["init"] == 1) {  // Index updated to 2 for ممتاز
        judgingCat[3].items[2]["init"] -= 1;
        some.value -= judgingCat[3].items[2]["nbr"];
      }

      // Remove points from ضعيف if already selected
      if (judgingCat[3].items[0]["init"] == 1) {  // Index updated to 0 for ضعيف
        judgingCat[3].items[0]["init"] -= 1;
        some.value -= judgingCat[3].items[0]["nbr"];
      }
    }
    // Logic for ممتاز
    else if (item['txt'] == 'ممتاز') {
      isAdaaSelected.value=true;
      judgCat.title["init"] = item["nbr"];
      some.value += pointsToAdd;

      // Remove points from حسن if already selected
      if (judgingCat[3].items[1]["init"] == 1) {  // Index updated to 1 for حسن
        judgingCat[3].items[1]["init"] -= 1;
        some.value -= judgingCat[3].items[1]["nbr"];
      }

      // Remove points from ضعيف if already selected
      if (judgingCat[3].items[0]["init"] == 1) {  // Index updated to 0 for ضعيف
        judgingCat[3].items[0]["init"] -= 1;
        some.value -= judgingCat[3].items[0]["nbr"];
      }
    }
    // Logic for ضعيف
    else if (item['txt'] == 'ضعيف') {
      isAdaaSelected.value=true;
      judgCat.title["init"] = 0;
      some.value += 0;

      // Remove points from حسن if already selected
      if (judgingCat[3].items[1]["init"] == 1) {  // Index updated to 1 for حسن
        judgingCat[3].items[1]["init"] -= 1;
        some.value -= judgingCat[3].items[1]["nbr"];
      }

      // Remove points from ممتاز if already selected
      if (judgingCat[3].items[2]["init"] == 1) {  // Index updated to 2 for ممتاز
        judgingCat[3].items[2]["init"] -= 1;
        some.value -= judgingCat[3].items[2]["nbr"];
      }
    }
    // Logic for points exceeding the allowed total
    else if (item['nbr'] > judgCat.title["init"]) {
      isLastOne.value = true;
      pointremoved.value = judgCat.title["init"];
      judgCat.title["init"] -= pointremoved.value;
      some.value -= pointremoved.value;
      update();
    }
    // Default case for other point removal scenarios
    else {
      judgCat.title["init"] -= pointsToAdd;
      some.value -= pointsToAdd;
      print(judgCat.title["init"]);
    }

    update();
  }
  void updatePointsTartil(Map<String, dynamic> item, JudgingCat judgCat) {
    double pointsToAdd = item['nbr'].toDouble();
    item['init'] += 1;
    print("hedhi init ${item['init']}");
    //print(item['pointsToAdd']);
  if (item['nbr'] > judgCat.title["init"]) {
    isLastOneTartil.value=true;
    pointremovedtartil.value =item['nbr']-judgCat.title["init"];
    judgCat.title["init"] -= pointremovedtartil.value;

    /*log("hedhi lkollll ${item['nbr']-judgCat.title["init"]}");
      log("hedhi wahda ${judgCat.title["init"]}");
      log("hedhi zooz ${item['nbr']}");*/
    tartilSome.value -= pointremovedtartil.value;
    update();

    }
    else {
      judgCat.title["init"] -= pointsToAdd;
      tartilSome.value -= pointsToAdd;
      print(judgCat.title["init"]);
    }

    update();
  }
  void updatePointsTafsir(Map<String, dynamic> item, JudgingCat judgCat, int index) {
    double pointsToAdd = item['nbr'].toDouble();
    item['init'] += 1;

    // Logic for صحيح
    if (item['txt'] == 'صحيح') {
      judgCat.title["init"] = item["nbr"];
      someTafsir.value += pointsToAdd;

      // Remove points from مرادف if already selected
      if (judgingCatTafsir[index].items[1]["init"] == 1) {
        judgingCatTafsir[index].items[1]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[1]["nbr"];
      }

      // Remove points from خطأ if already selected
      if (judgingCatTafsir[index].items[2]["init"] == 1) {
        judgingCatTafsir[index].items[2]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[2]["nbr"];
      }
    }
    // Logic for مرادف
    else if (item['txt'] == 'مرادف') {
      judgCat.title["init"] = item["nbr"];
      someTafsir.value += pointsToAdd;

      // Remove points from صحيح if already selected
      if (judgingCatTafsir[index].items[0]["init"] == 1) {
        judgingCatTafsir[index].items[0]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[0]["nbr"];
      }

      // Remove points from خطأ if already selected
      if (judgingCatTafsir[index].items[2]["init"] == 1) {
        judgingCatTafsir[index].items[2]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[2]["nbr"];
      }
    }
    // Logic for خطأ
    else if (item['txt'] == 'خطأ') {
      judgCat.title["init"] = 0;
      someTafsir.value += 0;

      // Remove points from صحيح if already selected
      if (judgingCatTafsir[index].items[0]["init"] == 1) {
        judgingCatTafsir[index].items[0]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[0]["nbr"];
      }

      // Remove points from مرادف if already selected
      if (judgingCatTafsir[index].items[1]["init"] == 1) {
        judgingCatTafsir[index].items[1]["init"] -= 1;
        someTafsir.value -= judgingCatTafsir[index].items[1]["nbr"];
      }
    }

    update();
  }


  void retry(Map<String, dynamic> item, JudgingCat judgingCat) {
    double pointsToAdd = item['nbr'].toDouble();

    item['init'] -= 1;
    print(item['init']);
    print(item['pointsToAdd']);

    if (item['txt'] == 'حسن' || item['txt'] == 'ممتاز') {
      judgingCat.title["init"] -= pointsToAdd;
      some.value -= pointsToAdd;
      print(judgingCat.title["init"]);
    } else if(isLastOne.value){
      judgingCat.title["init"] += pointremoved.value;
      some.value += pointremoved.value;
      isLastOne.value=false;
      update();
      print(judgingCat.title["init"]);
      print("hedhi hiya ya weldiiiii ${pointremoved.value.toString()}");
    }
    else {
      judgingCat.title["init"] += pointsToAdd;
      some.value += pointsToAdd;

      print(judgingCat.title["init"]);
    }
    update();
  }

  void retryTartil(Map<String, dynamic> item, JudgingCat judgingCat) {
    double pointsToAdd = item['nbr'].toDouble();

    item['init'] -= 1;
    print(item['init']);
    print(item['pointsToAdd']);

    if (item['txt'] == 'حسن' || item['txt'] == 'ممتاز') {
      judgingCat.title["init"] -= pointsToAdd;
      tartilSome.value -= pointsToAdd;
      print(judgingCat.title["init"]);
    }else if(isLastOneTartil.value){
      judgingCat.title["init"] += pointremovedtartil.value;
      tartilSome.value += pointremovedtartil.value;
      isLastOneTartil.value=false;
      update();
      print(judgingCat.title["init"]);
      print("hedhi hiya ya weldiiiii ${pointremovedtartil.value.toString()}");
    }
    else {
      judgingCat.title["init"] += pointsToAdd;
      tartilSome.value += pointsToAdd;

      print(judgingCat.title["init"]);
    }
    update();
  }

  void retryTafsir(Map<String, dynamic> item, JudgingCat judgingCat) {
    double pointsToAdd = item['nbr'].toDouble();

    item['init'] -= 1;
    print(item['init']);
    print(item['pointsToAdd']);

    if (item['txt'] == 'صحيح' || item['txt'] == 'مرادف') {
      judgingCat.title["init"] -= pointsToAdd;
      someTafsir.value -= pointsToAdd;
      print(judgingCat.title["init"]);
    } else if (isLastOne.value) {
      judgingCat.title["init"] += pointremoved.value;
      someTafsir.value += pointremoved.value;
      isLastOne.value = false;
      update();
      print(judgingCat.title["init"]);
      print("hedhi hiya ya weldiiiii ${pointremoved.value.toString()}");
    } else {
      judgingCat.title["init"] += pointsToAdd;
      someTafsir.value += pointsToAdd;

      print(judgingCat.title["init"]);
    }
    update();
  }

  void nextPage(ctx, {sub ,  String? question}) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) => AlertDialog(
        surfaceTintColor: Colors.white,
        title: const Text(
          'هل أنت متأكد؟',
          style: TextStyle(fontSize: 25),
          textDirection: TextDirection.rtl,
        ),
        content: const Text('سوف ننتقل إلى السؤال التالي.\nهل أنت متأكد؟',
            style: TextStyle(fontSize: 30), textDirection: TextDirection.rtl),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
            onPressed: () {
              Get.back();
              if (judgingCat[0].items[2]["init"] == 3 && judgingCat[0].title["init"] == 0) {
                isLastOne.value = false;
                judgingCat[0].items[2]["init"] -= 1;
                judgingCat[0].title["init"] += pointremoved.value;
                some.value += pointremoved.value;
                update();
              } else if (judgingCat[0].items[2]["init"] == 3) {
                judgingCat[0].items[2]["init"] -= 1;
                judgingCat[0].title["init"] += judgingCat[0].items[2]["nbr"];
                some.value += sub["nbr"].toDouble();
                update();
              }
              if (judgingCat[0].title["init"] == 0) {
                double pointsToAdd = sub["nbr"].toDouble();
                isLastOne.value = false;
                judgingCat[0].title["init"] += pointremoved.value;
                sub['init'] -= 1;
                some.value += pointremoved.value;
                update();
              }
            },
            child: const Text(
              'لا',
              style: TextStyle(
                  color: Colors.white,
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
              Get.back();
              pagecontroller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
              );

              // Add Tafsir score to the total
              if (question == 'التفسير') {
                some.value = someTafsir.value;
              }

              if (judgingCat[0].items[2]["init"] == 3 ||
                  judgingCat[0].title["init"] == 0) {
                some.value = 0;

              }
              if((judgingCat[0].items[2]["init"] == 3 ||
                  judgingCat[0].title["init"] == 0 )&& pageIndex.value == getLastPage()){
                await addAllScores();
                await addScore();
                Get.back();
              }

              await addAllScores();
              log(CompetitorID.value);
              log(catID.value);
              log(some.value.toString());
              resetData();
              resetTafsirData(); // Reset Tafsir data after moving to the next question
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
  void showAdaaConfirmation(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) => AlertDialog(
        surfaceTintColor: Colors.white,
        title: const Text(
          'تنبيه: لم يتم اختيار الأداء',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textDirection: TextDirection.rtl,
        ),
        content: const Wrap(
          children: [
            Text(
              'يُرجى تحديد الأداء المطلوب للمتابعة. يرجى النقر على الزر أدناه لاختيار الأداء.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'اختر الأداء الآن',
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
  void showMofradaConfirmation(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) => AlertDialog(
        surfaceTintColor: Colors.white,
        title: Text(
          mofrada1NotSelected() && mofrada2NotSelected()
              ? 'تنبيه: لم يتم اختيار المفردة 1 والمفردة 2'
              : mofrada1NotSelected()
              ? 'تنبيه: لم يتم اختيار المفردة 1'
              : 'تنبيه: لم يتم اختيار المفردة 2',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textDirection: TextDirection.rtl,
        ),
        content: Wrap(
          children: [
            Text(
              mofrada1NotSelected() && mofrada2NotSelected()
                  ? 'يُرجى تحديد المفردتين (1 و 2) للمتابعة. الرجاء النقر على الزر أدناه لاختيار المفردات المطلوبة.'
                  : mofrada1NotSelected()
                  ? 'يُرجى تحديد المفردة 1 للمتابعة. الرجاء النقر على الزر أدناه لاختيارها.'
                  : 'يُرجى تحديد المفردة 2 للمتابعة. الرجاء النقر على الزر أدناه لاختيارها.',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'اختر المفردات الآن',
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


  void previousPage(ctx) {
    if (pageIndex.value == 0) {
      Get.back();
      resetData();
      resetTartilData();
    } else {
      pagecontroller.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
    }
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _pagecontroller = PageController();
    resetData();
    resetTartilData();
    print('azeaezazze $q');
  }
  @override
  void onClose() {
    super.onClose();
    resetData();
    resetTartilData();
    resetTafsirData(); // Reset Tafsir data
    allScores.clear();
    total.value = 0;
  }

  void setCardClicked(Map<String, dynamic> item, value) {
    item['isCardClicked'] = value;
    update();
  }
bool adaaNotSelected() {
    return judgingCat[3].items[0]["init"]==0 && judgingCat[3].items[1]["init"]==0 && judgingCat[3].items[2]["init"]==0;
  }
  bool mofrada1NotSelected() {
    return judgingCatTafsir[0].items.every((item) => item["init"] == 0);
  }

  bool mofrada2NotSelected() {
    return judgingCatTafsir[1].items.every((item) => item["init"] == 0);
  }

  void resetData() {
    for (var cat in judgingCat) {
      cat.title["init"] = initialTitleInitValues[cat.title["title"]];
      for (var item in cat.items) {
        item["init"] = 0;
        item["isCardClicked"] = false;
      }
    }
    some.value = 18.0;
    update();
  }
  void resetTartilData() {
    for (var cat in judgingCatTartil) {
      cat.title["init"] = initialTitleInitValuesTartil[cat.title["title"]];
      for (var item in cat.items) {
        item["init"] = 0;
        item["isCardClicked"] = false;
      }
    }
    tartilSome.value = 20.0;
    update();
  }
  void resetTafsirData() {
    for (var cat in judgingCatTafsir) {
      cat.title["init"] = initialTitleInitValuesTafsir[cat.title["title"]];
      for (var item in cat.items) {
        item["init"] = 0;
        item["isCardClicked"] = false;
      }
    }
    someTafsir.value = 0.0;
    update();
  }


  Future<void> addAllScores() async {
    if (q[pageIndex.value]["title"] == 'التفسير') {
      // Always add Tafsir score, even for الأسرة القرآنية
      allScores[q[pageIndex.value]["title"]] = someTafsir.value;
      total.value += someTafsir.value;
    } else {
      // Add regular scores for other categories
      allScores[q[pageIndex.value]["title"]] = some.value;
      total.value += some.value;
    }
  }

  Future<void> addScore() async {
    await addAllScores();

    return note.add({
      'CategoryID': catID.value,
      'CompetitorID': CompetitorID.value,
      'JudgeID': judgeUid.value,
      ...allScores,
      'isDisabled': true,
      'total': total.value
    }).then((value) {
      print("All scores added");

      allScores.clear();
      total.value = 0;
      update();
    }).catchError((error) => log("Failed to add scores: $error"));
  }


  Future<void> addTartilScore() async {

    return note.add({
      'CategoryID': catID.value,
      'CompetitorID': CompetitorID.value,
      'JudgeID': judgeUid.value,
      'isDisabled': true,
      'total': tartilSome.value
    }).then((value) {
      print("All scores of tartil  added");


      update();
    }).catchError((error) => log("Failed to add scores: $error"));
  }

  void changeBtnText() {
    cat.value == "حفظ القرآن الكريم كاملا" &&
            pageIndex.value == q.length-1
        ? txt.value = "تسجيل الامتحان"
        : cat.value == "حفظ نصف القرآن" &&
                pageIndex.value == q.length-1
            ? txt.value = "تسجيل الامتحان"
            : (cat.value != "حفظ القرآن الكريم كاملا" &&
                        cat.value != "حفظ نصف القرآن") &&
                    pageIndex.value == q.length-1
                ? txt.value = "تسجيل الامتحان": cat.value == "الترتيل نظرا من المصحف"
                ?txt.value = "تسجيل الامتحان":txt.value = "التالي";
  }

  Future<String> fetchCategoryId(String catName) async {
    String catId = "";

    CollectionReference categories =
    FirebaseFirestore.instance.collection('Categories');
    QuerySnapshot categorySnapshot =
    await categories.where('categoryName', isEqualTo: catName).get();

    if (categorySnapshot.docs.isNotEmpty) {
      DocumentReference categoryRef = categorySnapshot.docs.first.reference;
      catId = categoryRef.id;
      return catId;
    }else{
      return "";
    }

  }
  int getLastPage() {
    switch (cat.value) {
      case "حفظ القرآن الكريم كاملا":
        return q.length;
      case "حفظ نصف القرآن":
        return q.length ;
      case "الترتيل نظرا من المصحف":
        return 0;
      default:
        return q.length ;
    }
  }


/*  Future<bool> checkDisabledStatus(String competitorID) async {
    final judgeID = judgeUid.value;

    final querySnapshot = await note
        .where('CompetitorID', isEqualTo: competitorID)
        .where('JudgeID', isEqualTo: judgeID)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }*/
}
