import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/button_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
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
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Rides')
                  .where('day', isEqualTo: date.day)
                  .where('month', isEqualTo: date.month)
                  .where('year', isEqualTo: date.year)
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        dateFromPicker(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(color: secondaryRed)),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextBold(
                                text: 'Date: ${dateController.text}',
                                fontSize: 16,
                                color: secondaryRed)),
                      ),
                    ),
                    ButtonWidget(
                      width: 150,
                      color: secondaryRed,
                      label: 'Print Report',
                      onPressed: () {
                        generatePdf(data.docs);
                      },
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Rides')
                  .where('day', isEqualTo: date.day)
                  .where('month', isEqualTo: date.month)
                  .where('year', isEqualTo: date.year)
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

  void generatePdf(List tableDataList) async {
    final pdf = pw.Document();
    final tableHeaders = [
      'No.',
      'Customer Name',
      'Ride',
      'Total Fee',
      'Date and Time',
    ];

    String cdate1 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

    List<List<String>> tableData = [];
    for (var i = 0; i < tableDataList.length; i++) {
      tableData.add([
        (1 + i).toString(),
        '${tableDataList[i]['name']}',
        '${tableDataList[i]['ride']}',
        '${tableDataList[i]['total']}.00php',
        DateFormat.yMMMd()
            .add_jm()
            .format(tableDataList[i]['dateTime'].toDate()),
      ]);
    }

    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        pageFormat: PdfPageFormat.letter,
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Amusement Park',
                    style: const pw.TextStyle(
                      fontSize: 18,
                    )),
                pw.SizedBox(height: 10),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                  'Reports',
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                  cdate1,
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            headerDecoration: const pw.BoxDecoration(),
            rowDecoration: const pw.BoxDecoration(),
            headerHeight: 25,
            cellHeight: 45,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
            },
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());

    final output = await getTemporaryDirectory();
    final file = io.File("${output.path}/payroll_report.pdf");
    await file.writeAsBytes(await pdf.save());
  }

  var date = DateTime.now();

  final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  void dateFromPicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        dateController.text = formattedDate;

        date = pickedDate;
      });
    } else {
      return null;
    }
  }
}
