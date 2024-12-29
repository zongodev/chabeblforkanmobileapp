import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NetworkConnectivity extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
        Get.rawSnackbar(
            messageText: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.wifi,
                  color: Colors.white,
                  size: 35,

                ),
                SizedBox(width: 10,),
                const Text(
                  'تم استعادة الاتصال بنجاح',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.green[400]!,
            snackStyle: SnackStyle.GROUNDED);
      }
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.red[100],
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى',
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        content: Text(
          'قد يكون هذا بسبب مشكلة في الشبكة الخاصة بك\n أو انقطاع في الخدمة',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        icon: Icon(
          Icons.wifi_off,
          size: 45,
        ),
        iconColor: Colors.red,
        contentPadding: EdgeInsets.all(40),
        iconPadding: EdgeInsets.all(20),
      ),
    );
  }
}
