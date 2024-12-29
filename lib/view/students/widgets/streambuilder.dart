import 'dart:developer';
import 'package:chabebalforqab/consts/firebaseconst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Models/competotormodel.dart';
import '../../../controller/compe=etitorcontroller.dart';

import '../../../controller/judgingdashcontroller.dart';
import '../../judgdashboard/judgdashboard.dart';
import 'dashboardcard.dart';

class StreamBuilderSpecific extends StatelessWidget {
  StreamBuilderSpecific({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;


  final DashController controller = Get.find();
  final CompetitorController competitorController =
      Get.put(CompetitorController());

  @override
  Widget build(BuildContext context) {
    log("students");
    return FutureBuilder<List<Competitor>>(
      future: competitorController.getCompetitorData(controller.catID.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'يوجد خطأ',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Column(

              children: [
                Lottie.asset("assets/images/empty.json"),
                SizedBox(height: 10.0),
                Text(
                  " .لا يوجد متسابقون في هذا الصنف",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Kufam",
                  ),
                ),
              ],
            ),
          );
        } else {

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 120),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 6,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final Competitor competitor = snapshot.data![index];
                      final String fullname =
                          "${competitor.name} ${competitor.lastName}";
                      return StreamBuilder(
                        stream: note
                            .where('CompetitorID', isEqualTo: competitor.id)
                            .where('JudgeID',
                                isEqualTo: controller.judgeUid.value)
                            .snapshots(),
                        builder: (context, disabledsnapshot) {
                          if (disabledsnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else if (disabledsnapshot.hasError) {
                            return Container();
                          } else {
                            if (disabledsnapshot.data!.docs.isEmpty) {
                              controller.isDisabled.value = false;
                            } else {
                              controller.isDisabled.value = true;

                            }
                            log(controller.isDisabled.value.toString());

                            log("${disabledsnapshot.data!.size} passed test");

                            return DashboardCard(
                              press: () {
                                controller.CompetitorID.value = competitor.id;
                                Get.to(
                                  () => JudgeDashboard(
                                    title: fullname,
                                    comCat: title,
                                  ),
                                );
                              },
                              Title: fullname,
                              iconSrc: "assets/images/studenticon.json",
                            );

                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

/*
* StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('participant')
          .where("categoryOfTheCompetition", isEqualTo: controller.catID.value)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Column(
            children: [
              Lottie.asset("assets/images/empty.json"),
              SizedBox(height: 10.0),
              Text(
                " .لا يوجد متسابقون في هذا الصنف",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Kufam"),
              ),
            ],
          );
        } else {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 120),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 6,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var participant = snapshot.data!.docs[index].data();
                      String firstName = participant['name'];
                      String lastName = participant['lastname'];
                      String fullname = "$firstName $lastName";
                      String compID = snapshot.data!.docs[index].id;

                      return
                          StreamBuilder(
                          stream:   FirebaseFirestore.instance.collection('note')
                              .where('CompetitorID', isEqualTo: compID)
                              .where('JudgeID', isEqualTo: judgeController.judgeUid.value)
                              .snapshots(),
                          builder: (context, disabledsnapshot) {
                            if (disabledsnapshot.connectionState == ConnectionState.waiting) {

                              return Container();
                            } else if (disabledsnapshot.hasError) {

                              return Container();
                            } else {
                              disabledsnapshot.data!.docs.isEmpty?controller.isDisabled.value=false:
                              controller.isDisabled.value=true;
                              log(controller.isDisabled.value.toString());
                              return DashboardCard(
                                press: () {
                                  controller.CompetitorID.value = snapshot.data!.docs[index].id;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JudgeDashboard(
                                        title: fullname,
                                        comCat: title,
                                      ),
                                    ),
                                  );
                                },
                                Title: fullname,
                                iconSrc: "assets/images/studenticon.json",


                              );
                            }
                          },

                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );*/
