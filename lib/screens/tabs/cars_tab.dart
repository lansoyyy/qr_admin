import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class CarsTab extends StatefulWidget {
  const CarsTab({Key? key}) : super(key: key);

  @override
  State<CarsTab> createState() => _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  late String filter = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                child: Container(
                  height: 40,
                  width: 400,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search plate number',
                      hintStyle: TextStyle(fontFamily: 'QRegular'),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Drivers')
                      .where('plate_number',
                          isGreaterThanOrEqualTo:
                              toBeginningOfSentenceCase(filter))
                      .where('plate_number',
                          isLessThanOrEqualTo:
                              '${toBeginningOfSentenceCase(filter)}z')
                      .snapshots(),
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
                      height: MediaQuery.of(context).size.height * 1,
                      width: MediaQuery.of(context).size.width * 1,
                      child: GridView.builder(
                          itemCount: data.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            final driverData = data.docs[index];
                            return Card(
                              elevation: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: iconColor,
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      height: 100,
                                      width: 150,
                                      child: Image.network(
                                          driverData['vehiclePic'] ?? '',
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBold(
                                            text:
                                                '${driverData['vehicle_model']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        TextBold(
                                            text:
                                                'Color: ${driverData['vehicle_color']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        TextBold(
                                            text:
                                                'Plate #: ${driverData['plate_number']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextBold(
                                            text:
                                                'Assigned Driver: ${driverData['name']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        TextBold(
                                            text:
                                                'Contact #: ${driverData['contact_number']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
