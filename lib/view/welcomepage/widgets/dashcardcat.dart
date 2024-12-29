import 'package:flutter/material.dart';

class DashboardCardCat extends StatelessWidget {
  final iconSrc;
  final Title;
  final scale;
  final Function() press;
  final width;

  const DashboardCardCat(
      {super.key,
        this.iconSrc,
        this.Title,
        this.scale,
        required this.press,
        this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 9,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios_new_outlined),
                  Row(
                    children: [
                      Text(
                        Title,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Kufam",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      iconSrc!=null?Image.asset(
                        iconSrc,
                        scale: scale,
                        width: width,
                      ):Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
