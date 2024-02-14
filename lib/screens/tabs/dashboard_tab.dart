import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/card_widget.dart';
import 'package:metro_admin/widgets/listtile_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardTab extends StatelessWidget {
  final colorList = <Color>[greenAccent, blueAccent, orangeAccent];

  DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 30,
                  width: 180,
                  decoration: BoxDecoration(
                    color: secondaryRed,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: TextBold(
                        text: 'Good day, Admin!',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Rides')
                            .where('status', isEqualTo: 'Done')
                            .snapshots(),
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
                          return CardWidget(
                            widget: ListTile(
                              trailing: Icon(
                                Icons.keyboard_double_arrow_up,
                                color: greenAccent,
                              ),
                              title: TextBold(
                                  text: 'Total Customers',
                                  fontSize: 18,
                                  color: blueAccent),
                              subtitle: TextBold(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  color: blueAccent),
                              leading: Container(
                                height: 100,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: iconColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.group_add,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Rides')
                            .where('status', isEqualTo: 'Done')
                            .snapshots(),
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

                          double earnings = 0;

                          for (int i = 0; i < data.docs.length; i++) {
                            earnings += data.docs[i]['payment'];
                          }
                          return CardWidget(
                            widget: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextBold(
                                      text: 'Total Sales',
                                      fontSize: 18,
                                      color: blueAccent),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LinearPercentIndicator(
                                    barRadius: const Radius.circular(100),
                                    width: 140,
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
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextBold(
                                        text: "₱${earnings.toStringAsFixed(2)}",
                                        fontSize: 12,
                                        color: Colors.grey),
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
                                    Icons.stacked_line_chart_sharp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Rides')
                            .snapshots(),
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
                          return CardWidget(
                            widget: ListTile(
                              title: TextBold(
                                  text: 'No. of Rides',
                                  fontSize: 18,
                                  color: blueAccent),
                              subtitle: TextBold(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  color: blueAccent),
                              leading: Container(
                                height: 100,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: iconColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.attractions,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBold(
                            text: 'Overall Statistics',
                            fontSize: 18,
                            color: blueAccent),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Rides')
                                .where('status', isEqualTo: 'Done')
                                .snapshots(),
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
                              return ListTileWidget(
                                  perct: data.docs.length.toDouble(),
                                  title: 'Number of Customers',
                                  subtitle: '${data.docs.length}',
                                  icon: Icons.group,
                                  color: greenAccent);
                            }),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Rides')
                                .snapshots(),
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
                              return ListTileWidget(
                                  perct: data.docs.length.toDouble(),
                                  subtitle: '${data.docs.length}',
                                  title: 'Number of Rides',
                                  icon: Icons.attractions,
                                  color: blueAccent);
                            }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 400,
                            width: 500,
                            decoration: BoxDecoration(
                              color: tileColorDashboard,
                            ),
                            child: Center(
                              child: SizedBox(
                                  width: 250,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Rides')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          print('error');
                                          return const Center(
                                              child: Text('Error'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.black,
                                            )),
                                          );
                                        }

                                        final data1 = snapshot.requireData;
                                        return StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('Rides')
                                                .where('status',
                                                    isEqualTo: 'Done')
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                print('error');
                                                return const Center(
                                                    child: Text('Error'));
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 50),
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.black,
                                                  )),
                                                );
                                              }

                                              final data2 =
                                                  snapshot.requireData;
                                              return PieChart(
                                                legendOptions:
                                                    const LegendOptions(
                                                        showLegends: true,
                                                        legendPosition:
                                                            LegendPosition
                                                                .bottom),
                                                dataMap: {
                                                  "Number of Customers": data2
                                                      .docs.length
                                                      .toDouble(),
                                                  "Number of Rides": data1
                                                      .docs.length
                                                      .toDouble(),
                                                },
                                                chartType: ChartType.disc,
                                                baseChartColor: Colors.grey[50]!
                                                    .withOpacity(0.15),
                                                colorList: colorList,
                                                chartValuesOptions:
                                                    const ChartValuesOptions(
                                                  showChartValuesInPercentage:
                                                      true,
                                                ),
                                                totalValue: (data1.docs.length +
                                                        data2.docs.length)
                                                    .toDouble(),
                                              );
                                            });
                                      })),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
