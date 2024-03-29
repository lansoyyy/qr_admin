import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../widgets/card_widget.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  int _index = 0;

  List<String> filters = ['Yearly'];

  String filter = '';
  String filterSearch = '';
  String filterType = '';

  List<String> days = [
    'Monday',
    'Tuesday',
    ' Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  dynamic driverData;

  List<int> daysValue = [1, 2, 3, 4, 5, 6, 7];

  List<String> weeks = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];

  List<int> weeksValue = [
    1,
    2,
    3,
    4,
  ];

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<int> monthsValue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  var selectedType = 0;

  String id = '';

  myFilter() {
    if (filter == 'Weekly') {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .snapshots();
    } else if (filter == 'Monthly') {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .where('week', isEqualTo: selectedType.toString())
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .where('month', isEqualTo: selectedType)
          .snapshots();
    }
  }

  myFilter1() {
    if (filter == 'Weekly') {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .snapshots();
    } else if (filter == 'Monthly') {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Rides')
          .where('year', isEqualTo: DateTime.now().year)
          .where('month', isEqualTo: selectedType)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _index != 0
                    ? IconButton(
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
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 20,
                ),
                TextBold(text: 'Sales', fontSize: 28, color: Colors.black),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IndexedStack(
              index: _index,
              children: [
                Options(),
                filter != 'Drivers Statement' ? Receipts() : const SizedBox(),
                id == '' ? Types() : const SizedBox(),
                Data(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Options() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: GestureDetector(
            onTap: (() {
              setState(() {
                _index = 1;
                filter = 'Sales Statement';
                id = '';
              });
            }),
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: blueAccent, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ListTile(
                  leading: Icon(
                    Icons.folder_copy_outlined,
                    color: blueAccent,
                    size: 32,
                  ),
                  title: TextBold(
                      text: 'Sales Statement', fontSize: 18, color: blueAccent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Receipts() {
    return Column(
      children: [
        for (int i = 0; i < filters.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: GestureDetector(
              onTap: (() {
                setState(() {
                  _index = 2;
                  filter = filters[i];
                });
              }),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: blueAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_month_outlined,
                      color: blueAccent,
                      size: 32,
                    ),
                    title: TextBold(
                        text: filters[i], fontSize: 18, color: blueAccent),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget Types() {
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: GridView.builder(
              itemCount: filter == 'Weekly'
                  ? days.length
                  : filter == 'Monthly'
                      ? weeks.length
                      : months.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: (() {
                      setState(() {
                        _index = 3;
                        if (filter == 'Weekly') {
                          selectedType = daysValue[index];
                          filterType = days[index];
                        } else if (filter == 'Monthly') {
                          filterType = weeks[index];
                          selectedType = weeksValue[index];
                        } else {
                          filterType = months[index];
                          selectedType = monthsValue[index];
                        }
                      });
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: ListTile(
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          title: TextBold(
                              text: filter == 'Weekly'
                                  ? days[index]
                                  : filter == 'Monthly'
                                      ? weeks[index]
                                      : months[index],
                              fontSize: 13,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              })),
        )
      ],
    );
  }

  Widget Data() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: TextBold(
                            text: filterType,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {});
                      }),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: myFilter(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Container(
                              height: 90,
                              width: 230,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: blueAccent, width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attractions,
                                    color: blueAccent,
                                    size: 58,
                                  ),
                                  title: TextRegular(
                                      text: 'Number of Rides',
                                      fontSize: 14,
                                      color: blueAccent),
                                  subtitle: TextBold(
                                      text: data.docs.length.toString(),
                                      fontSize: 38,
                                      color: blueAccent),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: myFilter1(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print('error');
                            return const Center(child: Text('Error'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              )),
                            );
                          }

                          final data = snapshot.requireData;
                          return Container(
                            height: 90,
                            width: 230,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.group,
                                  color: Colors.black,
                                  size: 58,
                                ),
                                title: TextRegular(
                                    text: 'Total Customer',
                                    fontSize: 14,
                                    color: Colors.black),
                                subtitle: TextBold(
                                    text: data.docs.length.toString(),
                                    fontSize: 38,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: myFilter(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      double earnings = 0;

                      for (int i = 0; i < data.docs.length; i++) {
                        earnings += data.docs[i]['total'];
                      }
                      return CardWidget(
                        width: 500,
                        widget: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBold(
                                  text: 'Total Sales Amount',
                                  fontSize: 18,
                                  color: blueAccent),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                barRadius: const Radius.circular(100),
                                width: 350,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 2000,
                                percent: data.docs.isEmpty ? 0 : 1,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.greenAccent,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextBold(
                                      text: "₱${earnings.toStringAsFixed(2)}",
                                      fontSize: 16,
                                      color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                          leading: Container(
                            height: 100,
                            width: 60,
                            decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: myFilter(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        width: 600,
                        height: 475,
                        child: GridView.builder(
                            itemCount: data.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: ((context, index) {
                              double payments = data.docs[index]['total'];
                              return Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextBold(
                                          text: DateFormat.yMMMd()
                                              .add_jm()
                                              .format(data.docs[index]
                                                      ['dateTime']
                                                  .toDate()),
                                          fontSize: 24,
                                          color: blueAccent),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextBold(
                                          text: 'Customers Name',
                                          fontSize: 12,
                                          color: Colors.grey),
                                      TextBold(
                                          text: data.docs[index]['name'],
                                          fontSize: 18,
                                          color: Colors.black),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextBold(
                                          text: 'Ride Name',
                                          fontSize: 12,
                                          color: Colors.grey),
                                      TextBold(
                                          text: data.docs[index]['ride'],
                                          fontSize: 18,
                                          color: Colors.black),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextBold(
                                          text: 'Total Fee',
                                          fontSize: 12,
                                          color: Colors.grey),
                                      TextBold(
                                          text:
                                              '${payments.toStringAsFixed(2)} php',
                                          fontSize: 18,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      );
                    }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
