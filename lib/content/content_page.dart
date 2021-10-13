import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantsuku_app/content/content_model.dart';
import 'package:rantsuku_app/create/create_page.dart';
import 'package:rantsuku_app/ranking.dart';

class ContentPage extends StatelessWidget {
  ContentPage(this.ranking);
  final Ranking ranking;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentModel>(
      create: (_) => ContentModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ranking.title),
        ),
        body: Consumer<ContentModel>(builder: (context, model, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                leading: Text(ranking.option1),
                title: Text('${ranking.votes1}票'),
                trailing: ElevatedButton(
                  child: Text('投票'),
                  onPressed: () async {
                    await model.incrementVotes1(ranking);
                  },
                ),
              ),
              ListTile(
                leading: Text(ranking.option2),
                title: Text('${ranking.votes2}票'),
                trailing: ElevatedButton(
                  child: Text('投票'),
                  onPressed: () async {
                    await model.incrementVotes2(ranking);
                  },
                ),
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePage(),
                fullscreenDialog: true,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
