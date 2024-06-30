import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String channelName;

  const ChatPage({super.key, required this.channelName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late String currentUserUid;

  @override
  void initState() {
    super.initState();
    // Get the current user's UID when the page initializes
    getCurrentUserUid();
  }

  Future<void> getCurrentUserUid() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        currentUserUid = currentUser.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('channels')
                  .doc(currentUserUid) // Use the current user's UID
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data!.docs[index];
                    final timestamp =
                        (message['timestamp'] as Timestamp).toDate();
                    final formattedDate =
                        DateFormat('dd-MM-yyyy ').format(timestamp);
                    final formattedTime = DateFormat('kk:mm').format(timestamp);
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                    15), // Adjust radius for specific corners
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(
                                    15), // Set to 0 to keep square
                                bottomRight: Radius.circular(
                                    0), // Set to 0 to keep square
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage({String? mediaUrl}) {
    String messageContent = _messageController.text.trim();
    if (messageContent.isNotEmpty || mediaUrl != null) {
      FirebaseFirestore.instance
          .collection('channels')
          .doc(currentUserUid) // Use the current user's UID
          .collection('messages')
          .add({
        'content': messageContent,
        'timestamp': DateTime.now(),
      });
      _messageController.clear();
    }
  }
}
