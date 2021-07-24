import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantsuku_app/create/create_model.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateModel>(
      create: (_) => CreateModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ランキング作成'),
        ),
        body: Consumer<CreateModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'タイトル',
                  ),
                  onChanged: (text) {
                    model.rankingTitle = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: '1つ目の選択肢',
                  ),
                  onChanged: (text) {
                    model.rankingOptionOne = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: '2つ目の選択肢',
                  ),
                  onChanged: (text) {
                    model.rankingOptionTwo = text;
                  },
                ),
                ElevatedButton(
                  child: Text('保存して作成'),
                  onPressed: () async {
                    try {
                      await model.add();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('投稿されました'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(e.toString()),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
