import 'dart:developer';

import 'package:chabebalforqab/controller/judgingdashcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../Models/competotormodel.dart';
import '../consts/firebaseconst.dart';
import '../controller/compe=etitorcontroller.dart'; // Corrected import statement

class CompetitorService {
  final _db = FirebaseFirestore.instance;
  final CompetitorController competitorController = Get.put(CompetitorController());
  final DashController dashController = Get.put(DashController());
  Future<List<Competitor>> getCompetitorDetails(String catId) async {
    final snapshot = await _db.collection("participant").where("categoryOfTheCompetition", isEqualTo: catId).get();
    log("${snapshot.size}");
    competitorController.numberOfCompetitor.value = snapshot.size;

    return snapshot.docs.map((e) => Competitor.fromSnapshot(e)).toList();
  }


}