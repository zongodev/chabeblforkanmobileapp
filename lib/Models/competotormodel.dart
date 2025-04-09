import 'package:cloud_firestore/cloud_firestore.dart';

class Competitor {
  final String id;
  final String name;
  final String lastName;
  final String birthdate;
  final String categoryOfTheCompetition;
  final String phoneNumber;
  final String sex;
  final String oldCompetition;
  final String associationName;
  final String accreditation;
  final Timestamp createdAt; // Keeping Firestore timestamp format

  Competitor({
    required this.id,
    required this.name,
    required this.lastName,
    required this.birthdate,
    required this.categoryOfTheCompetition,
    required this.phoneNumber,
    required this.sex,
    required this.oldCompetition,
    required this.associationName,
    required this.accreditation,
    required this.createdAt,
  });

  factory Competitor.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Document data is null");
    }

    return Competitor(
      id: doc.id,
      name: data['name'] as String? ?? '',
      lastName: data['lastname'] as String? ?? '',
      birthdate: data['birthdate'] as String? ?? '',
      categoryOfTheCompetition: data['categoryOfTheCompetition'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      sex: data['sex'] as String? ?? '',
      oldCompetition: data['oldCompetition'] as String? ?? '',
      associationName: data['associationName'] as String? ?? '',
      accreditation: data['accreditation'] as String? ?? '',
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }
}
