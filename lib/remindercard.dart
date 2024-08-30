import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String activity;
  final String day;
  final String time;
  final VoidCallback onDelete;

  const ReminderCard({
    required this.activity,
    required this.day,
    required this.time,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.notification_important, color: Colors.teal),
        title: Text(
          '$activity on $day at $time',
          style: TextStyle(color: Colors.teal.shade700),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
