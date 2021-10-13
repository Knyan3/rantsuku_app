import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rantsuku_app/ranking.dart';

class ContentModel extends ChangeNotifier {
  Future incrementVotes1(Ranking ranking) async {
    final doc =
        FirebaseFirestore.instance.collection('rankings').doc(ranking.id);
    await doc.update({
      'votes1': ++ranking.votes1,
    });
    notifyListeners();
  }

  Future incrementVotes2(Ranking ranking) async {
    final doc =
        FirebaseFirestore.instance.collection('rankings').doc(ranking.id);
    await doc.update({
      'votes2': ++ranking.votes2,
    });
    notifyListeners();
  }

  List<TextField> newOption = [];
  int optionCount = 3;
}
