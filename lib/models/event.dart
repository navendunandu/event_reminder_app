class Event {
  String id;
  String title;
  DateTime dateTime;

  Event({required this.id, required this.title, required this.dateTime});

  // Convert Event object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Create Event object from a map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
