
import 'package:get/get.dart';

import '../Models/competotormodel.dart';
import '../services/compitetorservice.dart';

class CompetitorController extends GetxController {
RxString fullName = "".obs;
RxInt numberOfCompetitor = 0.obs;
RxInt numberOfCompetitorPass = 0.obs;
  Future<List<Competitor>> getCompetitorData(String catId) async {
    return await CompetitorService().getCompetitorDetails(catId);
  }

  updateFullName(String Name){
    fullName.value=Name;
    update();
  }
}