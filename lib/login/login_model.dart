
import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier{

  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;
  bool isloading = false;

  void startLoading(){
    isloading = true;
    notifyListeners();
  }
  void endLoading(){
    isloading = false;
    notifyListeners();
  }

  void setemail (String email){
    this.email = email;
    notifyListeners();
  }
  void setpassword(String password){
    this.password = password;
    notifyListeners();
  }
  Future signup() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if(email != null && password != null) {
      //ここでログイン
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);

      final current = FirebaseAuth.instance.currentUser;
      final uid = current!.uid;
    }
  }

//
//   await FirebaseFirestore.instance.collection('books').doc(book.id).update({
//     'title': email,
//     'author': password,
//   });
//
// }
}