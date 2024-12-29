import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chabebalforqab/view/login/login.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/landbg.jpg"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Animated Splash Screen
          AnimatedSplashScreen(
            animationDuration: Duration(seconds: 4),
            backgroundColor: Colors.transparent,
            splashIconSize: 400,
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            splash: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/newbgbg.jpg",
                    /* colorFilter: ColorFilter.mode(
                        const Color(0xFF004B40), BlendMode.srcIn),*/
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  "وبالقرآن تحيا القلوب",
                  style: TextStyle(
                    color: const Color(0xFF004B40),
                    fontFamily: "Gulzar-Regular",
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            nextScreen: Login(),
          ),
        ],
      ),
    );
  }
}
