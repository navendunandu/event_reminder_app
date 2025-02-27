import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/firebase_service.dart';

class AddEventScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedDateTime;

  AddEventScreen({super.key});

  void addEvent(BuildContext context) {
    if (titleController.text.isNotEmpty && selectedDateTime != null) {
      Event event = Event(
        id: '', // ID is generated by Firestore
        title: titleController.text,
        dateTime: selectedDateTime!,
      );
      _firebaseService.addEvent(event);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Event Title"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    selectedDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                  }
                }
              },
              child: Text("Select Date & Time"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => addEvent(context),
              child: Text("Add Event"),
            ),
          ],
        ),
      ),
    );
  }
}
