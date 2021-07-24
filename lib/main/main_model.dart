import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rantsuku_app/ranking.dart';

class MainModel extends ChangeNotifier {
  List<String> _items = [
    '人気順',
    '新着順',
    'トレンド',
  ];

  String dropdownValue = '新着順';

  List<String> get items => _items;
  String get selected => dropdownValue;

  void setSelectedItem(String s) {
    dropdownValue = s;
    notifyListeners();
  }

  List<Ranking> rankings = [];

  void getRankings() {
    final snapshots =
        FirebaseFirestore.instance.collection('rankings').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final rankings = docs.map((doc) => Ranking(doc)).toList();
      rankings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.rankings = rankings;
      notifyListeners();
    });
  }
}
