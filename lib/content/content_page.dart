import 'package:flutter/material.dart';
import 'package:rantsuku_app/create/create_page.dart';

class ContentPage extends StatelessWidget {
  ContentPage(this.title, this.optionOne, this.optionTwo);
  String title, optionOne, optionTwo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(optionOne),
            trailing: ElevatedButton(
              child: Text('投票'),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text(optionTwo),
            trailing: ElevatedButton(
              child: Text('投票'),
              onPressed: () {},
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
  }
}
