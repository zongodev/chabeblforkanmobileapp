import 'package:flutter/material.dart';

import '../../../Models/judgeCategory.dart';
import 'dashcard.dart';
class DashRow extends StatelessWidget {
  const DashRow({
    Key? key,
    required this.subcategories,
    required this.judgcat,
  }) : super(key: key);

  final List subcategories;
  final JudgingCat judgcat;

  @override
  Widget build(BuildContext context) {
    final bool voice = judgcat.title["title"] == 'معايير الصوت';

    if (voice) {
      final int thirdLength = (subcategories.length / 3).ceil();
      final List firstThird = subcategories.take(thirdLength).toList();
      final List secondThird = subcategories.skip(thirdLength).take(thirdLength).toList();
      final List thirdThird = subcategories.skip(thirdLength * 2).toList();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var subcategory in firstThird)
                DashCard(sub: subcategory, judgingCat: judgcat),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var subcategory in secondThird)
                DashCard(sub: subcategory, judgingCat: judgcat),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var subcategory in thirdThird)
                DashCard(sub: subcategory, judgingCat: judgcat),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var subcategory in subcategories)
            DashCard(sub: subcategory, judgingCat: judgcat),
        ],
      );
    }
  }
}
