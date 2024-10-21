import 'dart:io';

import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';
// Import the necessary pages
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  File? _billImage;
  final picker = ImagePicker();
  String? _selectedCategory;
  DateTime? _issueDate;
  DateTime? _dueDate;
  String? _otherCategory;

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _billImage = File(pickedFile.path);
      }
    });
  }

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
          'Bills',
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
              // New Bill Section
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
                      child: const Text(
                        'New Bill',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223A6D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: _billImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.upload,
                                        color: Color(0xFF223A6D), size: 40.0),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Upload Image',
                                      style: TextStyle(
                                          color: Color(0xFF223A6D),
                                          fontSize: 16.0),
                                    ),
                                  ],
                                )
                              : Image.file(
                                  _billImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      hint: const Text('Bill Category'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
                      ),
                      items:
                          ['Electricity', 'Water', 'Internet', 'Phone', 'Other']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          if (_selectedCategory != 'Other') {
                            _otherCategory = null;
                          }
                        });
                      },
                    ),
                    if (_selectedCategory == 'Other')
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Specify Bill Type',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _otherCategory = value;
                            });
                          },
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => _selectDate(context, _issueDate, (date) {
                        setState(() {
                          _issueDate = date;
                        });
                      }),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDate(_issueDate)),
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => _selectDate(context, _dueDate, (date) {
                        setState(() {
                          _dueDate = date;
                        });
                      }),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDate(_dueDate)),
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedCategory == 'Other') {
                          print('Selected "Other" bill type: $_otherCategory');
                        } else {
                          print('Selected bill type: $_selectedCategory');
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
                      child: const Text('Save Bill',
                          style: TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF223A6D),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text('Show All Bills',
                          style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on ImagePicker {
  getImage({required ImageSource source}) {}
}
