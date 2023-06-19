import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/screen/home/model/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firehelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SignUp({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("success"))
        .catchError((e) => print("$e"));
  }

  SignIn({required email, required password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return "success";
    }).catchError((e) {
      return "$e";
    });
  }

  bool Checkuser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<String?> Googlesignin() async {
    String? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? auth = await user!.authentication;
    var crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = "success")
        .catchError((e) => msg = "failed : $e");
    return msg;
  }

  Future<void> insert(
      {
        required Name,
      required Price,
      required Quantity,
      required Desc,
      required Rate,
      required Image,}
  )
async {
    await firestore.collection('product').add({
      "Name": Name,
      "Price": Price,
      "Quantity": Quantity,
      "Desc": Desc,
      "Rate": Rate,
      "Image":Image,

    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> read()
  {
    return firestore.collection("product").snapshots();
  }
  Future<void> delete(String docid)
  async {
    await firestore.collection('product').doc(docid).delete();
  }
  void update(HomeModel homeModel,String docid)
  {
    firestore.collection('product').doc(docid).set({
      "Name":"${homeModel.name}",
      "Price":"${homeModel.price}",
      "Quantity":"${homeModel.quan}",
      "Desc":"${homeModel.desc}",
      "Rate":"${homeModel.rate}",
      "Image":"${homeModel.image}",

    });
  }
   Future<bool?> logout()
   async {
     bool? check;
     FirebaseAuth.instance.signOut().then((value) => check=true).catchError((e)=>check=false);
     await GoogleSignIn().signOut().then((value) => check=true);
     return check;
   }
}
