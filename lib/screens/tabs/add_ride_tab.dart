import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/services/add_rides.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/button_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:metro_admin/widgets/textfield_widget.dart';
import 'package:metro_admin/widgets/toast_widget.dart';

class AddRidesTab extends StatefulWidget {
  const AddRidesTab({super.key});

  @override
  State<AddRidesTab> createState() => _AddRidesTabState();
}

class _AddRidesTabState extends State<AddRidesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBold(text: 'Rides', fontSize: 28, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              ButtonWidget(
                width: 150,
                color: secondaryRed,
                label: 'Add Rides',
                onPressed: () {
                  addrideDialog(context, false, '');
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Rides List')
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
                          text: 'Ride Name',
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
                          text: '',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      DataColumn(
                        label: TextBold(
                          text: '',
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
                              text: '${data.docs[index]['name']}',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            TextRegular(
                              text: '${data.docs[index]['fee']}',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            ButtonWidget(
                              width: 150,
                              color: greenAccent,
                              label: 'Edit',
                              onPressed: () {
                                name.text = data.docs[index]['name'];
                                fee.text = data.docs[index]['fee'].toString();
                                addrideDialog(
                                    context, true, data.docs[index].id);
                              },
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            ButtonWidget(
                              width: 150,
                              color: primaryRed,
                              label: 'Delete',
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Delete Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this ride?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Rides List')
                                                    .doc(data.docs[index].id)
                                                    .delete();
                                                showToast(
                                                    'Deleted succesfully!');
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
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

  final name = TextEditingController();

  final fee = TextEditingController();

  addrideDialog(context, bool inEdit, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
              text: inEdit ? 'Updating Rides' : 'Adding Rides',
              fontSize: 18,
              color: Colors.black),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                label: 'Name of Ride',
                controller: name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Ride Fee',
                controller: fee,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextBold(
                text: 'Close',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (inEdit) {
                  await FirebaseFirestore.instance
                      .collection('Rides List')
                      .doc(id)
                      .update({'name': name.text, 'fee': fee.text});

                  showToast('Ride updated succesfully!');
                } else {
                  addRide(name.text, int.parse(fee.text));

                  showToast('Ride added succesfully!');
                }

                Navigator.pop(context);
              },
              child: TextBold(
                text: inEdit ? 'Update Ride' : 'Add Ride',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
