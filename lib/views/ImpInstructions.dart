import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImpInstructions extends StatelessWidget {
  const ImpInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Safety Guidelines"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Safety Guidelines',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 510,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fire.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Content container
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 510,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(227, 129, 129, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "FIRE",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "1. Install smoke detectors on every level of your home and test, them monthly.\n2. Keep fire extinguishers in accessible locations and ensure everyone knows how to use them.\n3. Plan and practice evacuation routes with your family regularly.\n4. Avoid overloading electrical outlets and unplug appliances when not in use.\n5. Keep flammable materials away from heat sources.",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/flood.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Content container
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 450,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(227, 129, 129, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Flood",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "1. Monitor weather reports and alerts from local authorities.\n 2. Sign up for emergency notifications if available.\n 3. Prepare an Emergency Kit which includes essentials like water, food, medications,first aid supplies, flashlights & batteries. \n4. Get to the highest level of your home if you are trapped and cannot evacuate. ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 450,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/earthquake.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Content container
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 450,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(227, 129, 129, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Earthquake",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "1. Drop to your hands and knees to prevent being knocked over. \n2.  your head and neck with your arms and seek shelter under a sturdy piece of furniture if available. \n3. Hold on to your shelter until the shaking stops \n4. Do not use elevators during or   immediately after an earthquake. \n5. Move away from windows, exterior walls, and doors.",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
