import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateModel extends ChangeNotifier {
  List<Widget> newOptions = [];

  String rankingTitle = '';
  String rankingOption1 = '';
  String rankingOption2 = '';
  String rankingNewOption = '';
  int votes1 = 0;
  int votes2 = 0;

  Future getOptions() async {
    newOptions = List.from(newOptions)
      ..add(
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '選択肢',
                ),
                onChanged: (text) {
                  rankingNewOption = text;
                },
              ),
            ),
            ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await getOptions();
              },
            ),
          ],
        ),
      );
    notifyListeners();
  }

  Widget addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          newOptions.insert(0, null);
        } else
          newOptions.removeAt(index);
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  Future addRanking() async {
    if (rankingTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    if (rankingOption1.isEmpty) {
      throw ('選択肢を入力してください');
    }
    if (rankingOption2.isEmpty) {
      throw ('選択肢を入力してください');
    }

    final collection = FirebaseFirestore.instance.collection('rankings');
    await collection.add({
      'title': rankingTitle,
      'option1': rankingOption1,
      'option2': rankingOption2,
      'votes1': votes1,
      'votes2': votes2,
      'createdAt': Timestamp.now(),
    });
    notifyListeners();
  }
}
