import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(String fullName, String email, String contactNumber,
    String address, String position) async {
  final docUser = FirebaseFirestore.instance.collection('Admin Users').doc();

  final json = {
    '_fullName': fullName,
    '_contactNumber': contactNumber,
    '_email': email,
    '_address': address,
    '_position': position,
  };

  await docUser.set(json);
}
