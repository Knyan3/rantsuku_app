import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rantsuku_app/ranking.dart';

class MainModel extends ChangeNotifier {
  List<Ranking> rankings = [];

  Future getRankings() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('rankings').get();
    final docs = snapshot.docs;
    final rankings = docs.map((doc) => Ranking(doc)).toList();
    this.rankings = rankings;
    notifyListeners();
  }
}
