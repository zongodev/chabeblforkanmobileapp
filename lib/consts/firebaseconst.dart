import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
/*final User? judge = authInstance.currentUser;
final judgeUID = judge!.uid;*/
CollectionReference note = FirebaseFirestore.instance.collection('note');
