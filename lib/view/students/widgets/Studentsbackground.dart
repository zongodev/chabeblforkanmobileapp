import 'package:flutter/material.dart';

class StudentsBackground extends StatelessWidget {
  const StudentsBackground({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset("assets/images/bg2.png"),
        ),
        Positioned(
          top: 40,
          child: Container(
            width: 393,
            height: 336,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.01, 1.00),
                end: Alignment(0.01, -1),
                colors: [Color(0xFFF6FAFC), Color(0xD8F6FAFC), Color(0x00F6FAFC)],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}