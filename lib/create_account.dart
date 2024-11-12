import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Assuming you have a login page

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After creating the user, navigate to the profile page or dashboard
      // Navigate to Profile page after sign-up
      Navigator.pushReplacementNamed(context, '/profile'); // Adjust navigation
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Sign Up Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter an email';
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) => password = value,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a password';
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
