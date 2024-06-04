import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project_name/ar_drawing_screen.dart'; // Change this to the correct path for AR drawing screen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                await Firebase.initializeApp(); // Initialize Firebase
                var email = emailController.text.trim();
                var password = passwordController.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }

                try {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

                  if (userCredential.user != null) {
                    // Save additional user data if needed
                    // For example, save user type to Firebase
                    await saveUserType(userCredential.user!.uid, 2); // Assuming user type 2 for regular users

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return ArDrawingScreen(); // Change this to the correct screen
                    }));
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    Fluttertoast.showToast(msg: 'Email already in use');
                  } else {
                    Fluttertoast.showToast(msg: 'Something went wrong');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Something went wrong');
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserType(String userId, int userType) async {
    DatabaseReference userTypeRef = FirebaseDatabase.instance.reference().child('users').child(userId).child('UserTypeId');
    await userTypeRef.set(userType);
  }
}
