import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future addMessage(
  String profilePicOfPersonToSend,
  String nameOfPersonToSend,
  String message,
  String receiverId,
  String myName,
) async {
  final docUser = FirebaseFirestore.instance
      .collection('admin')
      .doc(receiverId)
      .collection('Messages')
      .doc();

  final docUser1 =
      FirebaseFirestore.instance.collection('admin').doc(receiverId);

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
    'profilePicOfPersonToSend': profilePicOfPersonToSend,
  };

  final json1 = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
    'profilePicOfPersonToSend': profilePicOfPersonToSend,
  };

  await docUser1.set(json1);

  await docUser.set(json);
}

Future addMessage1(
  String profilePicOfPersonToSend,
  String nameOfPersonToSend,
  String message,
  String receiverId,
  String myName,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(receiverId)
      .doc('admin')
      .collection('Messages')
      .doc();

  final docUser1 =
      FirebaseFirestore.instance.collection(receiverId).doc('admin');

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'nameOfPersonToSend': myName,
    'message': message,
    'myName': nameOfPersonToSend,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
    'profilePicOfPersonToSend': profilePicOfPersonToSend
  };

  final json1 = {
    'nameOfPersonToSend': myName,
    'message': message,
    'myName': nameOfPersonToSend,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
    'profilePicOfPersonToSend': profilePicOfPersonToSend,
  };

  await docUser1.set(json1);

  await docUser.set(json);
}
