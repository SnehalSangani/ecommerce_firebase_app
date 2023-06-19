import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController txtemail=TextEditingController();
  TextEditingController txtpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          Center(child: Image.network("https://static.vecteezy.com/system/resources/previews/000/251/695/original/grocery-shopping-bag-vector-illustration.jpg")),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(0.75)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: txtemail,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      hintText: 'Enter Email',
                      label: Text("Email")
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: txtpassword,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    label: Text("Password"),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                  FirebaseHelper.firehelper.SignUp(email: txtemail.text, password: txtpassword.text);
                  Get.toNamed('/signin');

                }, child: Text("Sign up"))
              ],
            ),
          ),
        ],
      ),

    ));
  }
}
