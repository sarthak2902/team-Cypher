import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessagesPage extends StatelessWidget {
  final String channelId;

  MessagesPage({required this.channelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚠️ Alerts'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('channels')
            .doc(channelId)
            .collection('messages')
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No messages available'));
          }
          final messages = snapshot.data!.docs;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final timestamp = (message['timestamp'] as Timestamp).toDate();
              final formattedDate = DateFormat('dd-MM-yyyy ').format(timestamp);
              final formattedTime = DateFormat('kk:mm').format(timestamp);
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.8, // 80% of screen width
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 248, 186, 186),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              0), // Adjust radius for specific corners
                          topRight: Radius.circular(15),
                          bottomLeft:
                              Radius.circular(15), // Set to 0 to keep square
                          bottomRight:
                              Radius.circular(15), // Set to 0 to keep square
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "⚠️ Emergency Alert ",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Date: $formattedDate",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Time: $formattedTime",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              message['content'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
