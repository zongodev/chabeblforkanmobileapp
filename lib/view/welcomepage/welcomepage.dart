import 'dart:developer';

import 'package:chabebalforqab/categorylist.dart';

import 'package:chabebalforqab/controller/judgingdashcontroller.dart';
import 'package:chabebalforqab/view/students/students.dart';
import 'package:chabebalforqab/view/welcomepage/widgets/dashcardcat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/authservices.dart';

class WelcomePage extends StatelessWidget {
   WelcomePage({Key? key}) : super(key: key);
  DashController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    AuthServices().getCurrentJudge();
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        /* body: ,*/
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgr.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    right: 10,
                    child: MaterialButton(

                      onPressed: () {
                        AuthServices.signOut(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      height: 50,
                      elevation: 10,
                      color: const Color(0xFFd6b065),
                      child: const Row(

                        children: [
                          Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.logout),
                        ],
                      ),
                    ),
                  ),
                  Column(

                    //crossAxisAlignment: CrossAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      const SizedBox(height: 220,),
                      const Center(
                        child: Text(
                          "أصناف المسابقة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Color(0xFF004B40),
                              fontFamily: "Kufam",
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 90,),

                      Expanded(
                        child: GridView.builder(
                          padding:
                              const EdgeInsets.symmetric(vertical: 15, horizontal: 180),
                          itemCount: categories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 5,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return DashboardCardCat(
                              press: () async {
                                controller.catID.value= await controller.fetchCategoryId(categories[index]["cat"]);
                                controller.cat.value= categories[index]["cat"];
                                controller.getQuestionList(categories[index]["cat"]);
                                log("hedhi l cat ${controller.cat.value}");
                                log("$index");
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Students(id: index,);
                                  },
                                ));
                              },
                              iconSrc: categories[index]["icon"],
                              Title: categories[index]["title"],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
