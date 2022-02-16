import 'package:book_list_sample/register/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("新規登録"),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleController,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                        ),
                        onChanged: (text){
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
                        onChanged: (text){
                          //TODO:ここで取得したテキストを使う
                          model.setpassword(text);
                        },

                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed:() async{
                            model.startLoading;
                            //追加の処理
                            try {
                              await model.signup();
                               Navigator.of(context).pop();
                            }
                            catch(e){
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger .of(context).showSnackBar(snackBar);
                            } finally{
                              model.endLoading();
                            }
                          },

                          child: Text('登録する'))
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