import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/button_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBold(text: 'Reports', fontSize: 28, color: Colors.black),
              ButtonWidget(
                width: 150,
                color: secondaryRed,
                label: 'Print Report',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: DataTable(
              border: TableBorder.all(color: Colors.grey),
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => secondaryRed),
              columns: [
                DataColumn(
                  label: TextBold(
                    text: 'ID',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                DataColumn(
                  label: TextBold(
                    text: 'Customer Name',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                DataColumn(
                  label: TextBold(
                    text: 'Ride',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                DataColumn(
                  label: TextBold(
                    text: 'Ride Fee',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                DataColumn(
                  label: TextBold(
                    text: 'Date and Time',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) =>
                        index % 2 == 0 ? Colors.white : Colors.grey[300]!,
                  ),
                  cells: [
                    DataCell(
                      TextRegular(
                        text: (1 + index).toString(),
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      TextRegular(
                        text: 'Lance Olana',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      TextRegular(
                        text: 'Roller Coaster',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      TextRegular(
                        text: '₱100.00php',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      TextRegular(
                        text: 'January 01, 2024',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
