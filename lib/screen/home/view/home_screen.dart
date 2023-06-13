
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/screen/home/model/home_model.dart';
import 'package:ecommerce_firebase/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List<HomeModel> datalist=[];

  Widget build(BuildContext context) {
    TextEditingController txtname = TextEditingController();
    TextEditingController txtprice = TextEditingController();
    TextEditingController txtrate = TextEditingController();
    TextEditingController txtdesc = TextEditingController();
    TextEditingController txtqua = TextEditingController();
    TextEditingController txtimage = TextEditingController();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Ecommerce App"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            bool? msg= await FirebaseHelper.firehelper.logout();
            if(msg=true){
              Get.offNamed("signin");
              Get.snackbar("Login", "$msg");
            }

          }, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(builder: (context, snapshot) {
              if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
              else if(snapshot.hasData)
                {
                  QuerySnapshot? snapdata=snapshot.data;
                  datalist.clear();
                  for(var x in snapdata!.docs)
                    {
                      Map data=x.data() as Map;
                      String name=data['Name'];
                      String price=data['Price'];
                      String desc=data['Desc'];
                      String rate=data['Rate'];
                      String quan=data['Quantity'];
                      String image=data['Image'];
                      String docid = x.id;
                      HomeModel homemodel=HomeModel(
                        name: name,
                        price: price,
                        quan: quan,
                        rate: rate,
                        desc: desc,
                        docid: docid,
                        image: image,

                      );
                      datalist.add(homemodel);
                    }
                  return GridView.builder(
                    itemCount: datalist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 210), itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onDoubleTap: () async {
                         await FirebaseHelper.firehelper.delete(datalist[index].docid!);
                         Get.snackbar("Delete successfull", "");
                        },
                        onTap: () {

                          txtname = TextEditingController(text: datalist[index].name);
                          txtprice = TextEditingController(text: datalist[index].price);
                          txtrate = TextEditingController(text: datalist[index].rate);
                          txtdesc = TextEditingController(text: datalist[index].desc);
                          txtqua = TextEditingController(text: datalist[index].quan);
                          txtimage = TextEditingController(text: datalist[index].image);

                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: txtname,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                          hintText: 'Enter Name',
                                          //label: Text("Name"),
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
                                          //label: Text("Price"),
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
                                          //label: Text("Rate"),
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
                                          //label: Text("Desc"),
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
                                          //label: Text("Quantity"),
                                          labelStyle: TextStyle(color: Colors.black)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: txtimage,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                          hintText: 'Enter Iamge',
                                          //label: Text("Quantity"),
                                          labelStyle: TextStyle(color: Colors.black)),
                                    ),
                                    SizedBox(height: 30,),
                                    ElevatedButton(
                                        onPressed: () async {
                                          HomeModel homemodel =HomeModel(
                                            name: txtname.text,
                                            price: txtprice.text,
                                            quan: txtqua.text,
                                            desc: txtdesc.text,
                                            rate: txtrate.text,
                                            docid: datalist[index].docid,
                                          );
                                           FirebaseHelper.firehelper.update(homemodel, homemodel.docid!);
                                          Get.back();


                                        },

                                        child: Text("Update"))
                                  ],
                                ),
                              ),

                            );
                          },);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 100,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2,color: Colors.blue.shade900),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network("${datalist[index].image}")
                                // Text("${datalist[index].name}",style: TextStyle(fontSize: 20,
                                // ),),
                                // SizedBox(height: 20,),
                                // Text("\$ ${datalist[index].price}",style: TextStyle(fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },);


                }
              return CircularProgressIndicator();

            },stream: FirebaseHelper.firehelper.read(),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/second');

        },
        child: Icon(Icons.add),
      ),

    ));
  }

}
