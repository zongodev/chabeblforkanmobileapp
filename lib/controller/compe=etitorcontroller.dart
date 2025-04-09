import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Models/competotormodel.dart';
import '../services/compitetorservice.dart';

class CompetitorController extends GetxController {
  RxString fullName = "".obs;
  RxInt numberOfCompetitor = 0.obs;
  RxInt numberOfCompetitorPass = 0.obs;
  RxList<Competitor> competitorsList = <Competitor>[].obs;
  var filteredCompetitors = <Competitor>[].obs;
  RxBool isSearching = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches all competitors based on category ID
  Future<void> getCompetitorData(String catId) async {
    try {
      List<Competitor> competitors = await CompetitorService().getCompetitorDetails(catId);
      competitorsList.assignAll(competitors);
      filteredCompetitors.assignAll(competitors);
    } catch (e) {
      print("Error fetching competitors: $e");
    }
  }

  /// Search competitors dynamically
  void searchCompetitors(String name) {
    if (name.isEmpty) {
      filteredCompetitors.assignAll(competitorsList);
      isSearching.value = false;
    } else {
      isSearching.value = true;
      filteredCompetitors.assignAll(
        competitorsList.where((competitor) =>
            (competitor.name + " " + competitor.lastName)
                .toLowerCase()
                .contains(name.toLowerCase())),
      );
    }
  }
}
