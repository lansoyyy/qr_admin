import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';

PreferredSizeWidget customAppbar(page, page1, context) {
  return AppBar(
    foregroundColor: Colors.white,
    elevation: 0,
    backgroundColor: secondaryRed,
    actions: [
      const Icon(Icons.account_circle),
      const SizedBox(
        width: 10,
      ),
      Center(
          child: TextBold(
              text: 'Amusement Park Admin Panel',
              fontSize: 16,
              color: Colors.white)),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
