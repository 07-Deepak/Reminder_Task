import 'package:flutter/material.dart';

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.teal, size: 24),
          const SizedBox(width: 8.0),
          const Text('About Reminder App'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/app_logo.png', // Ensure you have an image in your assets folder
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Reminder App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'This app helps you set and manage your daily reminders with ease. Organize your schedule and never miss an important task again!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Text(
              '• Set reminders for different activities\n'
              '• Choose specific days and times\n'
              '• Receive notifications for upcoming reminders\n'
              '• Easy-to-use interface',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Developer: Your Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
