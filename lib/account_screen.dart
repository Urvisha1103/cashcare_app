import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accounts',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0C2551), // Dark blue color
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const DrawerMenu(), // Use the reusable drawer
      body: Container(
        color: const Color(0xFFB1D3F0), // Light blue background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Who Are You?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40), // Space between text and buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0C2551), // Dark blue background
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: () {
                  // Action for Parent (Bank Account Type) selection
                  print("Selected Account Type: Parent Bank Account");
                },
                child: const Text(
                  'Parent Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between buttons
            const Text(
              'Or',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2551),
              ),
            ),
            const SizedBox(height: 20), // Space between 'Or' and Child button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0C2551), // Dark blue background
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: () {
                  // Action for Child (Bank Account Type) selection
                  print("Selected Account Type: Child Bank Account");
                },
                child: const Text(
                  'Child Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
