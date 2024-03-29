import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/screens/tabs/add_ride_tab.dart';
import 'package:metro_admin/screens/tabs/bookings_screen.dart';
import 'package:metro_admin/screens/tabs/dashboard_tab.dart';
import 'package:metro_admin/screens/tabs/reports_tab.dart';
import 'package:metro_admin/screens/tabs/sales_tab.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/appbar_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  PageController page = PageController();
  SideMenuController page1 = SideMenuController();

  var drawerList = ['DASHBOARD', 'RIDES', 'SALES', 'REPORTS', 'ADD RIDES'];

  var icons = [
    Icons.dashboard,
    Icons.attractions,
    Icons.stacked_line_chart_sharp,
    Icons.report,
    Icons.add,
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> items = [
      for (int i = 0; i < drawerList.length; i++)
        SideMenuItem(
            icon: Icon(icons[i]),
            priority: i,
            title: drawerList[i],
            onTap: ((p0, p1) {
              page.jumpToPage(i);
              page1.changePage(i);
            })),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(page, page1, context),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 1000,
              color: Colors.white,
              child: SideMenu(
                controller: page1,
                style: SideMenuStyle(
                    unselectedTitleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'QBold',
                        fontWeight: FontWeight.w800),

                    // showTooltip: false,
                    displayMode: SideMenuDisplayMode.auto,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    hoverColor: primaryRed,
                    selectedColor: secondaryRed,
                    selectedIconColor: Colors.white,
                    unselectedIconColor: Colors.black
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
                    // backgroundColor: Colors.blueGrey[700]
                    ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attractions,
                        color: secondaryRed,
                        size: 75,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(
                        text: 'Amusement Park',
                        fontSize: 16,
                        color: secondaryRed,
                      ),
                    ],
                  ),
                ),
                items: items,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                DashboardTab(),
                const RidesScreen(),
                const SalesTab(),
                const ReportsTab(),
                const AddRidesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
