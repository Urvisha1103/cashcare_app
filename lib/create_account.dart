import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCDFF3), // Light blue background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223A6D), // Darker blue for text
                  ),
                ),

                const SizedBox(
                    height:
                        40.0), // Space between Create Account text and form fields

                // Full Name TextField
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                    labelText: 'Full Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20.0), // Space between Full Name and Email fields

                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20.0), // Space between Email and Password fields

                // Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        20.0), // Space between Password and Confirm Password fields

                // Confirm Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        20.0), // Space between Confirm Password and Sign-Up button

                // Sign Up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Sign up action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF223A6D), // Dark blue button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        20.0), // Space between Sign Up and Already Registered text

                // Already Registered? Login Here text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Registered?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login page
                        Navigator.pop(
                            context); // Assuming it navigates back to login
                      },
                      child: const Text(
                        'Login Here',
                        style: TextStyle(
                          color: Color(0xFF223A6D), // Dark blue text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
