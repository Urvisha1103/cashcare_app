import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class ExportDataPage extends StatefulWidget {
  const ExportDataPage({super.key});

  @override
  _ExportDataPageState createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  String _formatDate(DateTime? date) {
    return date != null
        ? DateFormat('dd MMM yyyy').format(date)
        : 'Select date';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCDFF3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF223A6D),
        title: const Text(
          'Export Data',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Export Data Section
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // Centering the "Export Data" text
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223A6D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => _selectDate(context, _startDate, (date) {
                        setState(() {
                          _startDate = date;
                        });
                      }),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Starting Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDate(_startDate)),
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => _selectDate(context, _endDate, (date) {
                        setState(() {
                          _endDate = date;
                        });
                      }),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Ending Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDate(_endDate)),
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement export logic here
                          if (_startDate != null && _endDate != null) {
                            print('Export data from $_startDate to $_endDate');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Please select both dates'),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF223A6D),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text('Export',
                            style: TextStyle(fontSize: 16.0)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Recent Exports Section
            ],
          ),
        ),
      ),
    );
  }
}
