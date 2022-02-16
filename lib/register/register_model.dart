
import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterModel extends ChangeNotifier{

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
    if(email != null && password != null){
      //ここでfirebase　authでユーザー作成
      final userCredential =await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;

      if(user != null) {
        final uid = user.uid;
        final doc =FirebaseFirestore.instance.collection('users').doc(uid);

        await doc.set({
          'uid':uid,
          'email':email,
        });
      }
    }
    //firebase storeに追加


  }

  //
  //   await FirebaseFirestore.instance.collection('books').doc(book.id).update({
  //     'title': email,
  //     'author': password,
  //   });
  //
  // }
}