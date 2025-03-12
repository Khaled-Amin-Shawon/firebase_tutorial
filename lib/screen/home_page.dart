import 'package:firebase_tutorial/firebase_service/firebase_authentication.dart';
import 'package:firebase_tutorial/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userID;
  const HomePage({super.key, required this.userID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Welcome, ${widget.userID}'),
          ElevatedButton(
            onPressed: () {
              // Perform any necessary logout logic
              FirebaseAuthentication().signOut();
              // Navigate to the login page
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthScreen())
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}