import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtname = TextEditingController();
    TextEditingController txtprice = TextEditingController();
    TextEditingController txtrate = TextEditingController();
    TextEditingController txtdesc = TextEditingController();
    TextEditingController txtqua = TextEditingController();
    TextEditingController txtimage = TextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Add Item"),

      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: txtname,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    label: Text("Name"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: txtprice,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Price',
                    label: Text("Price"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: txtrate,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Rate',
                    label: Text("Rate"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: txtdesc,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Description',
                    label: Text("Desc"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: txtqua,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Quantity',
                    label: Text("Quantity"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: txtimage,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter ImageUrl',
                    label: Text("Image Url"),
                    labelStyle: TextStyle(color: Colors.black)),
              ),

              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () async {
                   await FirebaseHelper.firehelper.insert(
                                 Name: txtname.text,
                                Price: txtprice.text,
                                Quantity: txtqua.text,
                                Desc: txtdesc.text,
                                Rate: txtrate.text,
                                Image: txtimage.text,
                             );
                           Get.back();

                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2,color: Colors.blue.shade900),
                    color: Colors.blue.shade100
                  ),
                  child: Center(
                    child: Text("Add",style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.bold,fontSize: 17),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
