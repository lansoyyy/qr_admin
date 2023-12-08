import 'package:flutter/material.dart';
import 'package:metro_admin/screens/tabs/bookings_tab/bookings_tab_view.dart';
import 'package:metro_admin/utils/colors.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  child: TabBar(
                      indicatorColor: primaryRed,
                      unselectedLabelColor: Colors.grey,
                      labelColor: primaryRed,
                      labelStyle: TextStyle(
                          color: primaryRed,
                          fontFamily: 'QBold',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      tabs: const [
                        Tab(
                          text: 'INSTANT BOOKING',
                        ),
                        Tab(
                          text: 'ADVANCE BOOKING',
                        ),
                        Tab(
                          text: 'BOOK A FRIEND',
                        ),
                      ]),
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(
              child: TabBarView(children: [
                BookingsTabView(
                  type: 'Book Now',
                ),
                BookingsTabView(
                  type: 'Advance Booking',
                ),
                BookingsTabView(
                  type: 'Book a Friend',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
