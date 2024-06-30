import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helplines extends StatefulWidget {
  const Helplines({super.key});

  @override
  State<Helplines> createState() => _HelplinesState();
}

class _HelplinesState extends State<Helplines> {
  final List<Map<String, String>> helplines = [
    {'name': 'Police', 'number': '100'},
    {'name': 'Fire', 'number': '101'},
    {'name': 'Ambulance', 'number': '102'},
    {'name': 'Disaster Management Services', 'number': '108'},
    {'name': 'Women Helpline', 'number': '1091'},
    {'name': 'Domestic Abuse for Women', 'number': '181'},
    {'name': 'Child Helpline', 'number': '1098'},
    {'name': 'Elder Abuse Helpline', 'number': '1800-180-1253'},
    {'name': 'Railway Enquiry', 'number': '139'},
    {'name': 'Railway Police', 'number': '1512'},
    {'name': 'Mental Health Helpline', 'number': '1800-599-0019'},
    {'name': 'Poison Control Helpline', 'number': '1800-11-6117'},
    {'name': 'Cyber Crime Helpline', 'number': '155260'},
    {'name': 'Road Accident Emergency Service', 'number': '1073'},
    {'name': 'Anti-Terror Helpline', 'number': '1090'},
    {'name': 'National AIDS Helpline', 'number': '1097'},
    {'name': 'Blood Bank Information', 'number': '104'},
    {'name': 'Tourist Helpline', 'number': '1363'},
  ];

  Future<void> launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Helplines'),
        backgroundColor: const Color.fromARGB(253, 218, 72, 71),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap:
                    true, // Use this to limit ListView height to the height of its content
                physics:
                    NeverScrollableScrollPhysics(), // Prevents ListView from scrolling independently
                itemCount: helplines.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 60,
                    margin: EdgeInsets.symmetric(
                        vertical: 5), // Add some vertical margin between items
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
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
                          helplines[index]['name']!,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Spacer(), // This takes up the remaining space in the row
                        GestureDetector(
                          onTap: () {
                            final phoneNumber = helplines[index]['number'];
                            final url = 'tel:$phoneNumber';
                            launchURL(url);
                          },
                          child: Icon(
                            Icons.call, // The icon you want to add
                            size: 20, // Icon size
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
