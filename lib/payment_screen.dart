import 'package:cashcare/CalendarPage.dart';
import 'package:cashcare/ExportDataPage.dart';
import 'package:cashcare/TransactionPage.dart';
import 'package:cashcare/account_screen.dart';
import 'package:cashcare/bills.dart';
import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:cashcare/dashboard.dart'; // Import necessary pages
import 'package:cashcare/currency_converter.dart'; // Currency Converter Page
// Profile Page

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C2551), // Dark blue color
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance container
            Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xFF0C2551), // Dark blue background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "₹ 12000.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Payment methods header
            Text(
              "Payment with...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2551), // Dark blue text
              ),
            ),
            SizedBox(height: 20),

            // Payment options list
            Expanded(
              child: ListView(
                children: [
                  PaymentMethodTile(
                    iconPath: 'assets/images/card.png', // Add an image for card
                    method: 'Card',
                  ),
                  PaymentMethodTile(
                    iconPath: 'assets/images/upi.png', // Add an image for UPI
                    method: 'UPI',
                  ),
                  PaymentMethodTile(
                    iconPath:
                        'assets/images/netbanking.png', // Add an image for Netbanking
                    method: 'Netbanking',
                  ),
                  PaymentMethodTile(
                    iconPath:
                        'assets/images/wallet.png', // Add an image for Wallet
                    method: 'Wallet',
                  ),
                  PaymentMethodTile(
                    iconPath:
                        'assets/images/pay_later.png', // Add an image for Pay Later
                    method: 'Pay Later',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFB1D3F0), // Light blue background
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String iconPath;
  final String method;

  const PaymentMethodTile(
      {super.key, required this.iconPath, required this.method});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(iconPath, width: 40, height: 40),
        title: Text(
          method,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C2551), // Dark blue text color
          ),
        ),
        onTap: () {
          // Handle onTap event here
          print('$method tapped');
        },
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPageWithDrawer()),
              );
            },
          ),
          DrawerItem(
            icon: Icons.payment,
            text: 'Payment',
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          DrawerItem(
            icon: Icons.currency_exchange,
            text: 'Currency',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrencyConverter()),
              );
            },
          ),
          DrawerItem(
            icon: Icons.receipt_long,
            text: 'Bills',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BillsPage()), // Create BillsPage
              );
            },
          ),
          DrawerItem(
            icon: Icons.account_balance,
            text: 'Accounts',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AccountScreen()), // Create AccountsPage
              );
            },
          ),
          DrawerItem(
            icon: Icons.swap_horiz,
            text: 'Transactions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransactionPage()), // Create TransactionsPage
              );
            },
          ),
          DrawerItem(
            icon: Icons.file_upload,
            text: 'Export data',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ExportDataPage()), // Create ExportDataPage
              );
            },
          ),
          DrawerItem(
            icon: Icons.calendar_today,
            text: 'Calendar',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CalendarPage()), // Create CalendarPage
              );
            },
          ),
          Divider(),
          DrawerItem(
            icon: Icons.settings,
            text: 'Setting',
            onTap: () {
              // Implement navigation to SettingsPage if you have one
            },
          ),
          DrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap; // Added callback for navigation

  const DrawerItem(
      {super.key, required this.icon, required this.text, required this.onTap});

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
        onTap(); // Call the navigation callback
        Navigator.pop(context); // Close the drawer on tap
      },
    );
  }
}
