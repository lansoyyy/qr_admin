import 'package:flutter/material.dart';
import 'package:metro_admin/screens/auth/login_page.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';

PreferredSizeWidget customAppbar(page, page1, context) {
  return AppBar(
    foregroundColor: Colors.white,
    elevation: 0,
    backgroundColor: secondaryRed,
    actions: [
      IconButton(
          onPressed: (() {
            page.jumpToPage(8);
            page1.changePage(8);
          }),
          icon: const Icon(Icons.email)),
      const SizedBox(
        width: 20,
      ),
      const Icon(Icons.account_circle),
      const SizedBox(
        width: 10,
      ),
      Center(
          child: TextBold(
              text: 'TAXI REGION 2', fontSize: 16, color: Colors.white)),
      const SizedBox(
        width: 10,
      ),
      IconButton(
          onPressed: (() {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        'Logout Confirmation',
                        style: TextStyle(
                            fontFamily: 'QBold', fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Are you sure you want to Logout?',
                        style: TextStyle(fontFamily: 'QRegular'),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                                fontFamily: 'QRegular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontFamily: 'QRegular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ));
          }),
          icon: const Icon(Icons.logout)),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
