import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class PassengersTab extends StatefulWidget {
  const PassengersTab({Key? key}) : super(key: key);

  @override
  State<PassengersTab> createState() => _PassengersTabState();
}

class _PassengersTabState extends State<PassengersTab> {
  late String filter = '';
  late String id = '';
  late int _index = 0;
  late int _newIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _index == 0
                  ? Card(
                      elevation: 3,
                      child: Container(
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              filter = value;
                            });
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search passenger's name",
                            hintStyle: TextStyle(fontFamily: 'QRegular'),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: (() {
                        setState(() {
                          _index -= 1;
                        });
                      }),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 32,
                        color: blueAccent,
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              IndexedStack(
                index: _index,
                children: [
                  ListUsers(),
                  id != ''
                      ? StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(id)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading'));
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            dynamic data = snapshot.data;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  child: Container(
                                    color: iconColor,
                                    height: 400,
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextBold(
                                              text: 'Profile',
                                              fontSize: 18,
                                              color: Colors.black),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: CircleAvatar(
                                              minRadius: 75,
                                              maxRadius: 75,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: NetworkImage(
                                                  '${data['profilePicture']}'),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: TextBold(
                                                text:
                                                    '${data['firstName']} ${data['lastName']}',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _newIndex = 0;
                                              });
                                            },
                                            child: TextRegular(
                                                text: 'Profile',
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _newIndex = 1;
                                              });
                                            },
                                            child: TextRegular(
                                                text: 'Emergency',
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _newIndex = 2;
                                              });
                                            },
                                            child: TextRegular(
                                                text: 'Transaction',
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(id)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: Text('Loading'));
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                            child:
                                                Text('Something went wrong'));
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }

                                      dynamic data = snapshot.data;
                                      return IndexedStack(
                                        index: _newIndex,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 20, 0, 20),
                                              child: SizedBox(
                                                  height: 500,
                                                  width: 450,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextBold(
                                                          text: 'Full Name',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['firstName']} ${data['lastName']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text:
                                                              'Contact Number',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['contactNumber']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text: 'Email',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['email']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text: 'Province',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['province']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text:
                                                              'City/Municipality',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['city']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text: 'Baranggay',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['brgy']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 20, 0, 20),
                                              child: SizedBox(
                                                  height: 500,
                                                  width: 450,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextBold(
                                                          text:
                                                              'Emergency Contact Detials',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text:
                                                              '${data['contactName1']}',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['contactNumber1']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['contactAddress1']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextBold(
                                                          text:
                                                              '${data['contactName2']}',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['contactNumber2']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                          text:
                                                              '${data['contactAddress2']}',
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Card(
                                              elevation: 10,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          30, 20, 0, 20),
                                                  child: SingleChildScrollView(
                                                    child: SizedBox(
                                                      height: 500,
                                                      width: 450,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 400,
                                                          child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Bookings')
                                                                  .where(
                                                                      'userId',
                                                                      isEqualTo:
                                                                          id)
                                                                  .snapshots(),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          QuerySnapshot>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  print(
                                                                      'error');
                                                                  return const Center(
                                                                      child: Text(
                                                                          'Error'));
                                                                }
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                50),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                                  );
                                                                }

                                                                final data =
                                                                    snapshot
                                                                        .requireData;
                                                                return SingleChildScrollView(
                                                                  child: DataTable(
                                                                      columns: [
                                                                        DataColumn(
                                                                          label: TextRegular(
                                                                              text: 'Date and Time',
                                                                              fontSize: 14,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        DataColumn(
                                                                          label: TextRegular(
                                                                              text: 'Ride Type',
                                                                              fontSize: 14,
                                                                              color: Colors.grey),
                                                                        ),
                                                                      ],
                                                                      rows: [
                                                                        for (int i =
                                                                                0;
                                                                            i < data.docs.length;
                                                                            i++)
                                                                          DataRow(cells: [
                                                                            DataCell(
                                                                              TextBold(text: DateFormat.yMMMd().add_jm().format(data.docs[i]['dateTime'].toDate()), fontSize: 18, color: Colors.black),
                                                                            ),
                                                                            DataCell(
                                                                              TextBold(text: data.docs[i]['type'], fontSize: 18, color: Colors.black),
                                                                            ),
                                                                          ])
                                                                      ]),
                                                                );
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            );
                          })
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListUsers() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('firstName',
                isGreaterThanOrEqualTo: toBeginningOfSentenceCase(filter))
            .where('firstName',
                isLessThan: '${toBeginningOfSentenceCase(filter)}z')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('error');
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
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: GridView.builder(
                itemCount: data.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: ((context, index) {
                  final passData = data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _index = 1;
                        id = passData.id;
                      });
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              minRadius: 40,
                              maxRadius: 40,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  NetworkImage('${passData['profilePicture']}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextBold(
                                text:
                                    '${passData['firstName']} ${passData['lastName']}',
                                fontSize: 14,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          );
        });
  }
}
