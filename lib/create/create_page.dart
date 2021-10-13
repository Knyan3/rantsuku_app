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
          return ListView(
            children: <Widget>[
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
                  labelText: '選択肢1',
                ),
                onChanged: (text) {
                  model.rankingOption1 = text;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '選択肢2',
                      ),
                      onChanged: (text) {
                        model.rankingOption2 = text;
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      await model.getOptions();
                    },
                  ),
                ],
              ),
              ...model.newOptions,
              Center(
                child: ElevatedButton(
                  child: Text('保存して作成'),
                  onPressed: () async {
                    try {
                      await model.addRanking();
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
              ),
            ],
          );
        }),
      ),
    );
  }
}
