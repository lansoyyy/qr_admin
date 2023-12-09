import 'package:flutter/material.dart';
import 'package:metro_admin/screens/tabs/bookings_tab/bookings_tab_view.dart';
import 'package:metro_admin/utils/colors.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: BookingsTabView(
        type: 'Book Now',
      ),
    );
  }
}
