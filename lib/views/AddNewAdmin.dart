import 'package:community_safety/models/authentication.dart';
import 'package:community_safety/views/AdminHome.dart';
import 'package:community_safety/views/AdminLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewAdmin extends StatefulWidget {
  const AddNewAdmin({super.key});

  @override
  State<AddNewAdmin> createState() => _AddNewAdminState();
}

class _AddNewAdminState extends State<AddNewAdmin> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              // Using LayoutBuilder to get the constraints
              builder: (context, constraints) {
                return SingleChildScrollView(
                  // Allows the content to be scrollable
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints
                          .maxHeight, // Minimum height set to the height of the viewport
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/logo_crop.png',
                              width: 150, height: 150),
                          const Text(
                            'AlertMe',
                            style: TextStyle(
                              fontSize: 34,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(
                                  255, 229, 74, 43), // Set text color to black
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 20),
                              child: TextField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  hintText: 'Username',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 20),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 20),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _isPasswordHidden,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Change the icon based on whether the password is hidden
                                      _isPasswordHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordHidden = !_isPasswordHidden;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: CupertinoButton(
                              onPressed: _signUp,
                              color: Color.fromARGB(255, 212, 79, 52),
                              borderRadius: BorderRadius.circular(50.0),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      showLoadingDialog(context);

      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (!mounted) return;
      Navigator.of(context).pop();

      if (user != null) {
        // print("User created Successfully ");

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'role': 'user',
        });
        if (!mounted) return;

        _showSuccessDialog(context, username, email);
      } else {
        // print("Error in creating User");
        _showFailedDialog(context);
      }
    } catch (e) {
      // print("Error: $e");
      _showFailedDialog(context);
      Navigator.of(context).pop();
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Creating User..."),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String username, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Account Created \n   Successfully",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void _showFailedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Registration Failed"),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "Registration failed...please check Firebase console to resolve the error"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
