import 'package:cloud_firestore/cloud_firestore.dart';

class Ranking {
  Ranking(DocumentSnapshot doc) {
    this.title = doc['title'];
    this.optionOne = doc['optionOne'];
    this.optionTwo = doc['optionTwo'];

    final Timestamp timestamp = doc['createdAt'];
    this.createdAt = timestamp.toDate();
  }

  String title;
  String optionOne;
  String optionTwo;
  DateTime createdAt;
}
