/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/judgingdashcontroller.dart';

import '../../judgdashboard/judgdashboard.dart';
import 'dashboardcard.dart';
class StreamBuilderAll extends StatelessWidget {
   StreamBuilderAll({
    super.key,
     required this.title,
  });


  final String title;
  DashController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('participant')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
          snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
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
                      var participant =
                      snapshot.data!.docs[index].data();
                      String firstName = participant['name'];
                      String lastName = participant['lastname'];
                      String fullname = "$firstName $lastName";

                      return DashboardCard(
                        scale: 0.6,
                        width: 70.0,
                        press: () {
                          print(controller.CompetitorID.value);
                          controller.CompetitorID.value = snapshot.data!.docs[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JudgeDashboard(
                                title: fullname,
                                comCat:title,
                              ),
                            ),
                          );
                        },
                        Title: fullname,
                        iconSrc: "assets/images/studenticon.json",
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
*/
