import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Assuming this is where you go after logging in

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After successful login, navigate to the Dashboard or Profile
      Navigator.pushReplacementNamed(
          context, '/dashboard'); // Adjust navigation
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Login Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
                  login();
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
