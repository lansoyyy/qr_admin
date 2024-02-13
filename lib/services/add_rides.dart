import 'package:cloud_firestore/cloud_firestore.dart';

Future addRide(String name, int fee) async {
  final docUser = FirebaseFirestore.instance.collection('Rides List').doc();

  final json = {
    'name': name,
    'fee': fee,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'uid': docUser.id,
    'day': DateTime.now().day,
    'month': DateTime.now().month,
    'year': DateTime.now().year,
  };

  await docUser.set(json);
}
