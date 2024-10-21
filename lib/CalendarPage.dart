import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// Import your Profile Page

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Event data
  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2024, 9, 3): [Event('Event A', 'Pay all Bills')],
    DateTime.utc(2024, 9, 5): [Event('Event B', 'Receive Money from XYZ')],
    DateTime.utc(2024, 10, 10): [Event('Event C', 'Receive Money from ABC')],
  };

  // Get events for selected day
  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFCCDFF3), // Light blue background color
      appBar: AppBar(
        backgroundColor: Color(0xFF223A6D), // Dark blue app bar color
        title: Text(
          'Calendar',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Calendar view
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: _getEventsForDay, // Event handler
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue[700],
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, // Hide the format button
                  titleCentered: true, // Center the title
                  leftChevronVisible: true, // Show left arrow
                  rightChevronVisible: true, // Show right arrow
                ),
              ),

              // Event list for the selected day wrapped in a ListView
              ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Prevent scrolling in this ListView
                children: _getEventsForDay(_selectedDay).map((event) {
                  return EventCard(
                    color: event.color,
                    title: event.title,
                    description: event.description,
                  );
                }).toList(),
              ),
              SizedBox(
                  height: screenSize.height *
                      0.02), // Add some spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build drawer items
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      onTap: onTap,
    );
  }
}

// Event card similar to the old design
class EventCard extends StatelessWidget {
  final Color color;
  final String title;
  final String description;

  const EventCard({
    super.key,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: screenSize.width * 0.02,
                  height: screenSize.width * 0.02,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(description),
          ],
        ),
      ),
    );
  }
}

// Event class to store event details
class Event {
  final String title;
  final String description;
  final Color color;

  Event(this.title, this.description) : color = _getEventColor(title);

  // Assign colors based on event type
  static Color _getEventColor(String title) {
    switch (title) {
      case 'Event A':
        return Colors.green;
      case 'Event B':
        return Colors.blue;
      default:
        return Colors.yellow;
    }
  }
}
