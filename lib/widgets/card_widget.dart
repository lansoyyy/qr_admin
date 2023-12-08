import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';

class CardWidget extends StatelessWidget {
  final Widget widget;
  double? width;
  Color? color;

  CardWidget(
      {super.key,
      required this.widget,
      this.width = 250,
      this.color = const Color(0xfffdffe4)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 5,
          child: Container(
            height: 120,
            width: width,
            decoration: BoxDecoration(
              color: color,
            ),
            child: Center(child: widget),
          ),
        ),
      ),
    );
  }
}
