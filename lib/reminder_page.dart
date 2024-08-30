import 'package:flutter/material.dart';
import 'package:reminder/NotificationHelper.dart';
import 'package:reminder/appbar/appbar.dart';
import 'package:reminder/remindercard.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  String? selectedDay;
  TimeOfDay? selectedTime;
  String? selectedActivity;
  List<Map<String, String>> reminders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Set Your Reminder',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 16.0),
            _buildDayPicker(),
            const SizedBox(height: 16.0),
            _buildTimePickerButton(),
            const SizedBox(height: 16.0),
            _buildActivityPicker(),
            const SizedBox(height: 32.0),
            _buildSetReminderButton(),
            const SizedBox(height: 16.0),
            _buildRemindersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDayPicker() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Day of the Week',
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.calendar_today, color: Colors.teal),
      dropdownColor: Colors.teal.shade50,
      style:
          TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold),
      items: daysOfWeek.map((String day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.teal),
              const SizedBox(width: 8.0),
              Text(day),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDay = value;
        });
      },
      isExpanded: true,
    );
  }

  Widget _buildTimePickerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.teal.shade700,
        backgroundColor: Colors.teal.shade50,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.teal, width: 2),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: _selectTime,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time, color: Colors.teal),
          const SizedBox(width: 8.0),
          Text(
            selectedTime != null
                ? selectedTime!.format(context)
                : 'Select Time',
            style: TextStyle(
              color: selectedTime != null ? Colors.teal.shade700 : Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPicker() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Activity',
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.local_activity, color: Colors.teal),
      dropdownColor: Colors.teal.shade50,
      style:
          TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold),
      items: activities.map((String activity) {
        return DropdownMenuItem<String>(
          value: activity,
          child: Row(
            children: [
              const Icon(Icons.local_activity, color: Colors.teal),
              const SizedBox(width: 8.0),
              Text(activity),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedActivity = value;
        });
      },
      isExpanded: true,
    );
  }

  Widget _buildSetReminderButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.notifications_active),
      label: const Text('Set Reminder'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _scheduleReminder,
    );
  }

  Widget _buildRemindersList() {
    return Expanded(
      child: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ReminderCard(
            activity: reminders[index]["activity"]!,
            day: reminders[index]["day"]!,
            time: reminders[index]["time"]!,
            onDelete: () {
              setState(() {
                reminders.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            colorScheme: const ColorScheme.light(primary: Colors.teal),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _scheduleReminder() {
    if (selectedDay != null &&
        selectedTime != null &&
        selectedActivity != null) {
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      NotificationHelper().scheduleNotification(
        scheduledTime,
        selectedActivity!,
      );

      setState(() {
        reminders.add({
          "day": selectedDay!,
          "time": selectedTime!.format(context),
          "activity": selectedActivity!,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reminder set for $selectedActivity on $selectedDay at ${selectedTime!.format(context)}',
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select all fields!'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}
