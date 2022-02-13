import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("本一覧"),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    GestureDetector(
                      child: SizedBox(
                      height: 160,
                      width: 100,
                      child: model.imageFile != null
                          ? Image.file(model.imageFile!) : Container(
                        color: Colors.grey,
                      ),
                  ),
                      onTap: ()async{
                    await model.pickImage();
                    },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '本のタイトル',
                        ),
                        onChanged: (text) {
                          model.title = text;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '本の著者',
                        ),
                        onChanged: (text) {
                          //TODO:ここで取得したテキストを使う
                          model.author = text;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            //追加の処理

                            try {
                              model.startLoading();
                              await model.addBook();
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              print(e);
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger .of(context).showSnackBar(snackBar);
                            } finally{
                              model.endLoading();
                            }
                          },
                          child: Text('追加する')
                      ),
                    ],
                  ),
                ),
                if(model.isloading)
                  Container(
                  color: Colors.black26,
                  child: Center(
                      child:CircularProgressIndicator(),
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
