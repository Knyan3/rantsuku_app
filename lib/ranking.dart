import 'package:cloud_firestore/cloud_firestore.dart';

class Ranking {
  Ranking(DocumentSnapshot doc) {
    this.id = doc.id;
    this.title = doc['title'];
    this.option1 = doc['option1'];
    this.option2 = doc['option2'];
    this.votes1 = doc['votes1'];
    this.votes2 = doc['votes2'];

    final Timestamp timestamp = doc['createdAt'];
    this.createdAt = timestamp.toDate();
  }

  String id;
  String title;
  String option1;
  String option2;
  int votes1;
  int votes2;
  DateTime createdAt;
}
