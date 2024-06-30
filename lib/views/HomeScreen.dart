import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_safety/channels.dart';
import 'package:community_safety/messages.dart';
import 'package:community_safety/views/AdminLogin.dart';
import 'package:community_safety/views/Helplines.dart';
import 'package:community_safety/views/ImpInstructions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "user";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'];
        });
      } else {
        setState(() {
          username = "No username found";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AlertMe',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(253, 218, 72, 71),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: 325,
              height: 236,
              padding: const EdgeInsets.only(top: 15),
              color: const Color.fromARGB(253, 218, 72, 71),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/CommunitySafety.jpg'), // use the URL from the API response
                  ),
                  SizedBox(height: 10),
                  Text(
                    "AlertMe",
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.022,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.note_add_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Emergency Instruction',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ImpInstructions()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Helplines',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Helplines()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_gmailerrorred,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Regions',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ChannelsPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Admin Login',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const LoginScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text(
                      'logout',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(253, 218, 72, 71),
                  // borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Image.asset("assets/images/avatar.png"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Explore Communities !",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 160,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('channels')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No channels available'));
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
                                      color: Colors.grey
                                          .withOpacity(0.3), // shadow color
                                      spreadRadius:
                                          1, // how much spread you want
                                      blurRadius: 2, // how much blur you want
                                      offset: const Offset(0,
                                          3), // offset changes the shadow position
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      channel['name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(), // This takes up the remaining space in the row
                                    const Icon(
                                      Icons
                                          .arrow_forward_ios, // The icon you want to add
                                      size: 20, // Icon size
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const Text(
                "Having an Emergency ?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Press the button below."),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const Helplines()));
                },
                child: Image.asset(
                  "assets/images/button1.png",
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Text(
              //   "Stay Happy, Stay Safe !",
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
