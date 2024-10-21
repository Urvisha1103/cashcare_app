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
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
       drawer: DrawerMenu(), // Use the reusable drawer
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
                  // Handle Parent button press
                  print("Selected: Parent");
                },
                child: const Text(
                  'Parent',
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
                  // Handle Child button press
                  print("Selected: Child");
                },
                child: const Text(
                  'Child',
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0C2551), // Dark blue background
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF0C2551), // Dark blue icon
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          DrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
          ),
          DrawerItem(icon: Icons.payment, text: 'Payment'),
          DrawerItem(icon: Icons.currency_exchange, text: 'Currency'),
          DrawerItem(icon: Icons.receipt, text: 'Bills'),
          DrawerItem(icon: Icons.account_balance, text: 'Accounts'),
          DrawerItem(
              icon: Icons.transfer_within_a_station, text: 'Transactions'),
          DrawerItem(icon: Icons.file_upload, text: 'Export data'),
          DrawerItem(icon: Icons.calendar_today, text: 'Calendar'),
          Divider(),
          DrawerItem(icon: Icons.settings, text: 'Setting'),
          DrawerItem(icon: Icons.logout, text: 'Logout'),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const DrawerItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF0C2551)), // Dark blue icon color
      title: Text(
        text,
        style: TextStyle(
          color: Color(0xFF0C2551), // Dark blue text color
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        // Handle navigation or action when item is tapped
        Navigator.pop(context); // Close the drawer on tap
      },
    );
  }
}
