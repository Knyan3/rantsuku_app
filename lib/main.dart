import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantsuku_app/main_model.dart';

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
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getRankings(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(' '),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            final rankings = model.rankings;
            return ListView(
              children: rankings
                  .map(
                    (ranking) => ListTile(
                      title: Text(ranking.title),
                    ),
                  )
                  .toList(),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
