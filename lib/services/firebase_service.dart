import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEvent(Event event) async {
    await _db.collection('events').add(event.toMap());
  }

  Stream<List<Event>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromMap(doc.data()..['id'] = doc.id);
      }).toList();
    });
  }

  Future<void> deleteEvent(String id) async {
    await _db.collection('events').doc(id).delete();
  }
}
