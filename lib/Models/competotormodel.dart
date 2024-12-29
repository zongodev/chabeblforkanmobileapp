import 'package:cloud_firestore/cloud_firestore.dart';

class Competitor {
  final String id;
  final String name;
  final String lastName;


  Competitor( {
    required this.id,
    required this.name,
    required this.lastName,

  });

  factory Competitor.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) { 
    final data = doc.data()!;
    return Competitor(
      id: doc.id,
      name: data['name'] ?? '',
      lastName: data['lastname'] ?? '',
      
    );
  }
}
