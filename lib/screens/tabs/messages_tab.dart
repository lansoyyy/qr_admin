import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/services/add_message.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  String query = '';

  String id = '';
  String otherId = '';

  final msgController = TextEditingController();

  late String profilePicture;
  late String name;
  late String receiverId;

  final cont = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cont.jumpTo(cont.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search messages",
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
                  height: 30,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .where('nameOfPersonToSend',
                            isGreaterThanOrEqualTo:
                                toBeginningOfSentenceCase(query))
                        .where('nameOfPersonToSend',
                            isLessThan: '${toBeginningOfSentenceCase(query)}z')
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
                        height: 500,
                        width: 300,
                        child: ListView.builder(
                            itemCount: data.docs.length,
                            itemBuilder: ((context, index) {
                              final userData = data.docs[index];
                              return Card(
                                elevation: 3,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      id = userData.id;
                                      otherId = userData['id'];
                                    });
                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/552/552848.png'),
                                  ),
                                  trailing: TextBold(
                                      text: DateFormat.jm().format(
                                          userData['dateTime'].toDate()),
                                      fontSize: 14,
                                      color: Colors.black),
                                  title: Text(
                                    userData['message'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontFamily: 'QRegular'),
                                  ),
                                  subtitle: Text(
                                    'from: ${userData['nameOfPersonToSend']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'QBold'),
                                  ),
                                ),
                              );
                            })),
                      );
                    })
              ],
            ),
          ),
          const VerticalDivider(),
          id != ''
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(id)
                      .doc('admin')
                      .collection('Messages')
                      .orderBy('dateTime')
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
                      width: 500,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: cont,
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                final userData = data.docs[index];

                                // Check if message is from sender or receiver

                                // Build chat bubble based on sender/receiver status

                                name = userData['nameOfPersonToSend'];
                                receiverId = userData.id;
                                profilePicture =
                                    userData['profilePicOfPersonToSend'];
                                return Row(
                                  mainAxisAlignment:
                                      userData['myName'] == 'Admin'
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          userData['myName'] == 'Admin'
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15.0),
                                          decoration: BoxDecoration(
                                            color: userData['myName'] == 'Admin'
                                                ? secondaryRed
                                                : blueAccent,
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(20.0),
                                              topRight:
                                                  const Radius.circular(20.0),
                                              bottomLeft: userData['myName'] ==
                                                      'Admin'
                                                  ? const Radius.circular(20.0)
                                                  : const Radius.circular(0.0),
                                              bottomRight: userData['myName'] ==
                                                      'Admin'
                                                  ? const Radius.circular(0.0)
                                                  : const Radius.circular(20.0),
                                            ),
                                          ),
                                          child: Text(
                                            userData['message'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextRegular(
                                            text: DateFormat.jm().format(
                                                userData['dateTime'].toDate()),
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: msgController,
                                        decoration: InputDecoration(
                                          hintText: 'Type a message',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.send),
                                      onPressed: () {
                                        addMessage(profilePicture, name,
                                            msgController.text, id, 'Admin');

                                        addMessage1(profilePicture, name,
                                            msgController.text, id, 'Admin');

                                        cont.jumpTo(
                                            cont.position.maxScrollExtent);

                                        msgController.clear();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : const SizedBox()
        ],
      ),
    );
  }
}
