import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';

import '../../widgets/add_user_dialog.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String id = '';

  late dynamic userData1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const InputDialog();
              },
            );
          }),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                          text: 'User Management',
                          fontSize: 18,
                          color: Colors.black),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Admin Users')
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
                            return SizedBox(
                              width: 350,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemCount: data.docs.length,
                                  itemBuilder: ((context, index) {
                                    final userData = data.docs[index];
                                    return Card(
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              id = userData.id;
                                              userData1 = userData;
                                            });
                                          },
                                          leading: CircleAvatar(
                                            maxRadius: 50,
                                            minRadius: 50,
                                            child: Image.network(
                                                'https://cdn-icons-png.flaticon.com/512/666/666201.png'),
                                          ),
                                          title: TextBold(
                                              text: userData['_position'],
                                              fontSize: 14,
                                              color: Colors.black),
                                          subtitle: TextRegular(
                                              text: userData['_fullName'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                          trailing: IconButton(
                                            onPressed: (() async {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Delete'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this user?'),
                                                    actions: [
                                                      TextButton(
                                                        child: TextRegular(
                                                            text: 'Cancel',
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: TextRegular(
                                                            text: 'Delete',
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                        onPressed: () async {
                                                          // Perform delete operation here

                                                          setState(() {
                                                            id = '';
                                                          });
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Admin Users')
                                                              .doc(userData.id)
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }),
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  id != ''
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: 400,
                            decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  maxRadius: 50,
                                  minRadius: 50,
                                  child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/666/666201.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBold(
                                    text: userData1['_fullName'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Full Name',
                                    fontSize: 12,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBold(
                                    text: userData1['_email'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Email Address',
                                    fontSize: 12,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBold(
                                    text: userData1['_contactNumber'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Contact Number',
                                    fontSize: 12,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBold(
                                    text: userData1['_address'],
                                    fontSize: 18,
                                    color: Colors.black),
                                TextRegular(
                                    text: 'Complete Address',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 300,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
