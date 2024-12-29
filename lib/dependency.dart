import 'package:chabebalforqab/controller/network_connectivity.dart';
import 'package:get/get.dart';



class DependencyInjection {

  static void init() {
    Get.put<NetworkConnectivity>(NetworkConnectivity(),permanent:true);
  }
}