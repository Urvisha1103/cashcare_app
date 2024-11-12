import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String address = '';

  Future<void> saveProfile() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Save profile data to Firestore
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile Updated')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => name = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) => phone = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) => address = value,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your address' : null,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  saveProfile();
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
