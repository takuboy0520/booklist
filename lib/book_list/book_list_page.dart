
import 'package:book_list_sample/add_book/add_book_page.dart';
import 'package:book_list_sample/domain/book.dart';
import 'package:book_list_sample/editbook/edit_book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooklist(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("本一覧"),
        ),
        body: Center(
          child:Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if(books == null){
              return CircularProgressIndicator();
            }
            final List <Widget> widgets = books
                .map(
                    (book) => Slidable(
                      actionPane: SlidableDrawerActionPane(
                      ),
                      child: ListTile(
                          title:Text(book.title),
                          subtitle:Text(book.author),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: '編集',
                          color: Colors.black45,
                          icon: Icons.edit,
                          onTap: () async{
                            //編集画面に遷移
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> EditBookPage(book),
                              ),
                            );

                            if (title != null) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('$titleが追加されました'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                            model.fetchBooklist();

                          }
                        ),
                        IconSlideAction(
                          caption: '削除',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            //削除しますかと出す

                          },
                        ),
                      ],
                    )
            ).toList();
            return ListView(
                children:widgets,
            );
          }),
        ),
        floatingActionButton:Consumer<BookListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed:() async{
               final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> AddBookPage(),
                  fullscreenDialog: true,
                  ),
                );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本が追加されました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBooklist();

            },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          }
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}