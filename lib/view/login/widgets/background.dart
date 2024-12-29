import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;
 /* Future<void> preloadBackgroundImage(BuildContext context) async {
    await precacheImage(AssetImage('assets/images/background_image.jpg'), context);
  }*/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginbg.png",),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
