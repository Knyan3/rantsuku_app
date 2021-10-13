import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rantsuku_app/ranking.dart';

class MainModel extends ChangeNotifier {
  String text = '';

  List<String> searchList = [];

  List<String> searchResultList = [];

  void search() {
    if (this.text.isNotEmpty) {
      searchResultList.clear();
      this.searchList.forEach(
        (element) {
          if (element.contains(this.text)) {
            searchResultList.add(element);
          }
        },
      );
      notifyListeners();
    }
  }

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

  void fetchRankings() {
    final snapshot =
        FirebaseFirestore.instance.collection('rankings').snapshots();
    snapshot.listen((snapshot) {
      final docs = snapshot.docs;
      final rankings = docs.map((doc) => Ranking(doc)).toList();
      rankings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.rankings = rankings;
      notifyListeners();
    });
  }
}
