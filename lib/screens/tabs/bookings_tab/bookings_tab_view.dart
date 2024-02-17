import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
import '../../../utils/colors.dart';
import '../../../widgets/card_widget.dart';

class BookingsTabView extends StatefulWidget {
  final String type;

  const BookingsTabView({super.key, required this.type});

  @override
  State<BookingsTabView> createState() => _BookingsTabViewState();
}

class _BookingsTabViewState extends State<BookingsTabView> {
  late String filter = '';
  late int filterDate = 0;
  late int filterMonth = 0;
  late int filterYear = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidget(
                      widget: ListTile(
                        trailing: Icon(
                          Icons.keyboard_double_arrow_up,
                          color: greenAccent,
                        ),
                        title: TextBold(
                            text: 'No. of Rides',
                            fontSize: 18,
                            color: blueAccent),
                        subtitle: StreamBuilder<QuerySnapshot>(
                            stream: filterDate == 0
                                ? FirebaseFirestore.instance
                                    .collection('Rides')
                                    .where('year',
                                        isEqualTo: DateTime.now().year)
                                    .where('month',
                                        isEqualTo: DateTime.now().month)
                                    .where('day', isEqualTo: DateTime.now().day)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('Rides')
                                    .where('year', isEqualTo: filterYear)
                                    .where('month', isEqualTo: filterMonth)
                                    .where('day', isEqualTo: filterDate)
                                    .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
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
                              return TextBold(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  color: blueAccent);
                            }),
                        leading: Container(
                          height: 100,
                          width: 60,
                          decoration: BoxDecoration(
                            color: iconColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.local_taxi_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBold(
                        text: '  Overview', fontSize: 24, color: Colors.black),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: filterDate == 0
                            ? FirebaseFirestore.instance
                                .collection('Rides')
                                .where('year', isEqualTo: DateTime.now().year)
                                .where('month', isEqualTo: DateTime.now().month)
                                .where('day', isEqualTo: DateTime.now().day)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('Rides')
                                .where('year', isEqualTo: filterYear)
                                .where('month', isEqualTo: filterMonth)
                                .where('day', isEqualTo: filterDate)
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
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
                          return SizedBox(
                            width: 300,
                            height: 500,
                            child: ListView.builder(
                                itemCount: data.docs.length,
                                itemBuilder: ((context, index) {
                                  final passData = data.docs[index];

                                  Timestamp timestamp = passData['dateTime'];
                                  DateTime dateTime = timestamp.toDate();
                                  String formattedDateTime =
                                      DateFormat('MMM').format(dateTime);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Card(
                                      child: Container(
                                        color: iconColor,
                                        width: 180,
                                        height: 65,
                                        child: ListTile(
                                          trailing: SizedBox(
                                            width: 120,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: TextBold(
                                                      text:
                                                          '₱${passData['total']}.00',
                                                      fontSize: 18,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ),
                                          title: SizedBox(
                                            width: 275,
                                            child: TextBold(
                                                text: passData['name'],
                                                fontSize: 16,
                                                color: blueAccent),
                                          ),
                                          subtitle: TextRegular(
                                              text:
                                                  '${passData['ride']} - ${passData['persons']}',
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                          );
                        })
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: MonthView(
                      controller: EventController(),
                      // to provide custom UI for month cells.
                      cellBuilder: (date, events, isToday, isInMonth) {
                        // Return your widget to display as month cell.
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: isToday ? Colors.blue : null,
                            ),
                            child: Center(
                                child: TextBold(
                                    text: date.day.toString(),
                                    fontSize: 18,
                                    color: Colors.black)));
                      },

                      minMonth: DateTime(1990),
                      maxMonth: DateTime(2050),

                      initialMonth:
                          DateTime(DateTime.now().year, DateTime.now().month),

                      cellAspectRatio: 1,
                      onPageChange: (date, pageIndex) =>
                          print("$date, $pageIndex"),
                      onCellTap: (events, date) {
                        setState(() {
                          filterDate = date.day;
                          filterMonth = date.month;
                          filterYear = date.year;
                        });
                        // Implement callback when user taps on a cell.
                      },
                      startDay: WeekDays
                          .sunday, // To change the first day of the week.
                      // This callback will only work if cellBuilder is null.
                      onEventTap: (event, date) => print(event),
                      onDateLongPress: (date) => print(date),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
