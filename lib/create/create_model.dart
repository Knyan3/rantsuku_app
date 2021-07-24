import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateModel extends ChangeNotifier {
  String rankingTitle = '';
  String rankingOptionOne = '';
  String rankingOptionTwo = '';

  Future add() async {
    if (rankingTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    if (rankingOptionOne.isEmpty) {
      throw ('選択肢を入力してください');
    }
    if (rankingOptionTwo.isEmpty) {
      throw ('選択肢を入力してください');
    }

    final collection = FirebaseFirestore.instance.collection('rankings');
    await collection.add({
      'title': rankingTitle,
      'optionOne': rankingOptionOne,
      'optionTwo': rankingOptionTwo,
      'createdAt': Timestamp.now(),
    });
  }
}
