import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'messages.dart';

class ChannelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regions'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('channels').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No channels available'));
          }
          final channels = snapshot.data!.docs;
          return ListView.builder(
            itemCount: channels.length,
            itemBuilder: (context, index) {
              final channel = channels[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MessagesPage(channelId: channel.id),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(253, 218, 72, 71),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3), // shadow color
                            spreadRadius: 1, // how much spread you want
                            blurRadius: 2, // how much blur you want
                            offset: const Offset(
                                0, 3), // offset changes the shadow position
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            channel['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Spacer(), // This takes up the remaining space in the row
                          Icon(
                            Icons.arrow_forward_ios, // The icon you want to add
                            size: 20, // Icon size
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
