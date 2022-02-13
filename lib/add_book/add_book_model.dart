
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier{
  //test
 String? title;
 String? author;
 File? imageFile;
 bool isloading = false;

 final picker = ImagePicker();

 void startLoading(){
   isloading = true;
   notifyListeners();
 }
 void endLoading(){
   isloading = false;
   notifyListeners();
 }
//aaaa
   Future addBook() async{
   if(title==null || title == ''){
    throw'本のタイトルが入力されていません';
   }
   if(author==null || author == ''){
    throw'著者が入力されていません';
   }

   final doc = FirebaseFirestore.instance.collection('books').doc();
   String? imgURL;

   if(imageFile != null){
     //もしイメージファイル入っていたらstrageにアップする
    final task = await FirebaseStorage.instance
         .ref('books/${doc.id}')
         .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
   }
   //firestore についか
   await doc.set({
    'title': title,
    'author': author,
     'imgURL': imgURL,
   });

  }

 Future pickImage() async {
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null) {
     imageFile = File(pickedFile.path);
   }
 }
}