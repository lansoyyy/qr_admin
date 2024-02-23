import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ListTileWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String subtitle;
  final String title;
  final double perct;

  const ListTileWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.color,
      required this.perct});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBold(text: title, fontSize: 18, color: blueAccent),
            const SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              barRadius: const Radius.circular(100),
              width: 180,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: perct * 0.1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: color,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:
                  TextRegular(text: subtitle, fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        leading: Container(
          height: 100,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
