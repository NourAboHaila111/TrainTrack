
import 'package:flutter/material.dart';

import '../../layout/triantrack_layout.dart';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  final String role;

  HomeScreen({required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // استخدم هذه الطريقة لإرجاع المحتوى حسب التبويب والدور
  Widget getCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return widget.role == 'Trainer'
            ? TrainerLayout()
            : EmployeeLayout(searchController: TextEditingController());
      case 1:
        return InboxScreen(role: widget.role);
      case 2:
        return MyWorkScreen(role: widget.role);
      default:
        return Center(child: Text('Unknown Tab'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Work',
          ),
        ],
      ),
    );
  }
}

// inbox_screen.dart

// Inbox screen
class InboxScreen extends StatelessWidget {
  final String role;

  InboxScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inbox")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: List.generate(5, (index) => _inboxItem(index)),
      ),
    );
  }

  Widget _inboxItem(int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.mail_outline, color: Colors.blueAccent),
        title: Text("Message #$index"),
        subtitle: Text("This is a message for $role."),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

// My Work screen
class MyWorkScreen extends StatelessWidget {
  final String role;

  MyWorkScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Work")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: List.generate(5, (index) => _workItem(index)),
      ),
    );
  }

  Widget _workItem(int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.assignment_turned_in, color: Colors.green),
        title: Text("Task #$index"),
        subtitle: Text("Assigned to $role"),
        trailing: Icon(Icons.check_circle_outline),
        onTap: () {},
      ),
    );
  }
}

