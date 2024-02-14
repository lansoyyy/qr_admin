import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          TextBold(text: 'Reports', fontSize: 28, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (() async {}),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: secondaryRed)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextBold(
                          text:
                              'Date: ${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
                          fontSize: 16,
                          color: secondaryRed)),
                ),
              ),
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
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Rides')
                  .where('day', isEqualTo: DateTime.now().day)
                  .where('month', isEqualTo: DateTime.now().month)
                  .where('year', isEqualTo: DateTime.now().year)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SingleChildScrollView(
                  child: DataTable(
                    border: TableBorder.all(color: Colors.grey),
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => secondaryRed),
                    columns: [
                      DataColumn(
                        label: TextBold(
                          text: 'No.',
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
                      data.docs.length,
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
                              text: data.docs[index]['name'],
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            TextRegular(
                              text: data.docs[index]['ride'],
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            TextRegular(
                              text: '₱${data.docs[index]['total']}.00php',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            TextRegular(
                              text: DateFormat.yMMMd().add_jm().format(
                                  data.docs[index]['dateTime'].toDate()),
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
                );
              }),
        ],
      ),
    );
  }
}
