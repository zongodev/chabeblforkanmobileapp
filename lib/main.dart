
import 'package:chabebalforqab/controller/judgingdashcontroller.dart';
import 'package:chabebalforqab/dependency.dart';
import 'package:chabebalforqab/view/landingpage/landingpage.dart';
import 'package:chabebalforqab/view/login/login.dart';
import 'package:chabebalforqab/view/welcomepage/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(DashController());


  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    return  ScreenUtilInit(
      designSize: Size(360, 600),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(

        getPages: [
          GetPage(name: "/welcomePage", page: () => WelcomePage(),),
          GetPage(name: "/login", page: () => Login(),),

        ],
        debugShowCheckedModeBanner: false,
        home:  auth.currentUser==null?Landing(): WelcomePage(),
         //home: Login(),
      ),
    );
  }
}
