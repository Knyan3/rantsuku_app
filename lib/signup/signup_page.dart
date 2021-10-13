import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantsuku_app/main/main_page.dart';
import 'package:rantsuku_app/signup/signup_model.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('サインアップ'),
        ),
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'メールアドレス',
                  ),
                  onChanged: (text) {
                    model.mail = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                  ),
                  obscureText: true,
                  onChanged: (text) {
                    model.password = text;
                  },
                ),
                ElevatedButton(
                  child: Text('登録する'),
                  onPressed: () async {
                    try {
                      await model.signUp();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('登録完了しました'),
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
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
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
