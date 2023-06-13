
import 'package:ecommerce_firebase/screen/home/view/home_screen.dart';
import 'package:ecommerce_firebase/screen/home/view/second_screen.dart';
import 'package:ecommerce_firebase/screen/signin/signin_screen.dart';
import 'package:ecommerce_firebase/screen/signup/signup_screen.dart';
import 'package:ecommerce_firebase/screen/splash/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(builder: (context, orientation, deviceType) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page:() =>  Splash(),),
        GetPage(name: '/signin', page:() =>  Signin(),),
        GetPage(name: '/signup', page:() =>  Signup(),),
        GetPage(name: '/home', page:() =>  Home(),),
        GetPage(name: '/second', page:() =>  Second(),),
      ],
    )),
  );
}