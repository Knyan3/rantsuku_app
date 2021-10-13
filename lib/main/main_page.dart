import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantsuku_app/content/content_page.dart';
import 'package:rantsuku_app/create/create_page.dart';
import 'package:rantsuku_app/main/main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ランつくアプリ',
      theme: ThemeData(primaryColor: Colors.white),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..fetchRankings(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              onChanged: (text) {
                model.text = text;
                model.search();
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'キーワード検索',
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Center(
                child: DropdownButton<String>(
                  value: model.dropdownValue,
                  onChanged: (String newValue) {
                    model.setSelectedItem(newValue);
                  },
                  items: model.items.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: ListView(
                  children: model.rankings
                      .map(
                        (ranking) => ListTile(
                          title: Text(ranking.title),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentPage(ranking),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
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
        );
      }),
    );
  }
}
