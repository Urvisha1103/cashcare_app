import 'package:flutter/material.dart';
import 'update_profile_page.dart'; // Import the update profile page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCDFF3), // Light blue background color
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF223A6D), // Dark blue background for AppBar
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0), // Spacing from top

            // Profile Picture
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage(
                  'images/profile_pic.png'), // Replace with your image asset
              backgroundColor: Colors.white,
            ),

            const SizedBox(height: 20.0),

            // User Name
            const Text(
              'Name', // Replace with user's name
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF223A6D), // Dark blue text
              ),
            ),

            const SizedBox(height: 10.0),

            // User Email
            const Text(
              'example@email.com', // Replace with user's email
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 40.0), // Space before buttons

            // Update Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the Update Profile Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage()),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Update Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF223A6D), // Dark blue button color
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20.0), // Space between buttons

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logout action
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF223A6D), // Dark blue button color
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
