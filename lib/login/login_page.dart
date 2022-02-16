import 'package:book_list_sample/domain/book.dart';
import 'package:book_list_sample/register/register_model.dart';
import 'package:book_list_sample/register/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ログイン"),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleController,
                        decoration: InputDecoration(
                          hintText: 'ログイン',
                        ),
                        onChanged: (text) {
                          model.setemail(text);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: model.authorController,
                        decoration: InputDecoration(
                          hintText: 'password',
                        ),
                        onChanged: (text) {
                          //TODO:ここで取得したテキストを使う
                          model.setpassword(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            model.startLoading();
                            //追加の処理
                            try {
                              await model.signup();
                              Navigator.of(context).pop();
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }finally{
                              model.endLoading();
                            }
                          },
                          child: Text('ログイン')),
                      TextButton(
                          onPressed: () async {
                            //追加の処理
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text('新規登録の方はこちら'))
                    ],
                  ),
                ),
                if (model.isloading)
                  Container(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
