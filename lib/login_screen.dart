import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project_name/ar_drawing_screen.dart'; // Change this to the correct path for AR drawing screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                var email = emailController.text.trim();
                var password = passwordController.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }

                try {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

                  if (userCredential.user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return ArDrawingScreen(); // Change this to the correct screen
                    }));
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    Fluttertoast.showToast(msg: 'User not found');
                  } else if (e.code == 'wrong-password') {
                    Fluttertoast.showToast(msg: 'Wrong password');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Something went wrong');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
