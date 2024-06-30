import 'package:community_safety/models/authentication.dart';
import 'package:community_safety/views/AddNewAdmin.dart';
import 'package:community_safety/views/AdminHome.dart';
import 'package:community_safety/views/HomeScreen.dart';
import 'package:community_safety/views/forgotPass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

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
                          // Password Input Field
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
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword()));
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.002,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: CupertinoButton(
                              onPressed: _signIn,
                              color: const Color.fromARGB(255, 229, 74, 43),
                              borderRadius: BorderRadius.circular(50.0),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AddNewAdmin()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a member? ',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.022,
                                    color: Color.fromARGB(255, 51, 51, 51),
                                  ),
                                ),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.022,
                                    color: Color.fromARGB(255, 51, 51, 51),
                                  ),
                                ),
                              ],
                            ),
                          )
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      // Show a loading indicator while logging in
      showLoadingDialog(context);

      // Sign in with Firebase Authentication
      User? user = await _auth.signInWithEmailndPassword(email, password);

      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pop();

      if (user != null) {
        // print("User logged in successfully ");

        // Retrieve user details from Cloud Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          // Get the user's role from the Firestore document
          String role = userSnapshot['role'];

          // Redirect based on the user's role
          if (!mounted) return;
          if (role == 'user') {
            Navigator.of(context).pop();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (role == 'admin') {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          } else {
            // Handle other roles or redirect to a default screen
            print("Unknown role: $role");
          }
        } else {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('User Not Found'),
                content: const Text('User document not found in Firestore.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (!mounted) return;
        // Show an error dialog for invalid credentials
        showInvalidCredentialsDialog(context);
      }
    } catch (e) {
      // Dismiss the loading indicator in case of an error
      Navigator.of(context, rootNavigator: true)
          .pop(); // Ensure you close any open dialogs

      // Handle the error by showing an AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('An error has occurred: $e'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the error dialog
                },
              ),
            ],
          );
        },
      );
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
              Text("Just a second"),
            ],
          ),
        );
      },
    );
  }

  void showInvalidCredentialsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invalid Credentials"),
          content:
              const Text("Please check your email and password and try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
