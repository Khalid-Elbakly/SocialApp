import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/home_layout.dart';
import 'package:socialapp/modules/login/cubit/cubit.dart';
import 'package:socialapp/modules/login/cubit/states.dart';
import 'package:socialapp/modules/login/login_screen.dart';
import 'package:socialapp/shared/network/endpoints.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Fluttertoast.showToast(msg: 'onBackgrond');
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  await CacheHelper.init();
  uID = CacheHelper.getData(key: 'uId');
//  print(uID);

  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: 'onMessage'
    );
    print(event.data);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(msg: 'onMessageOpenApp');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Widget widget;
  if(uID != null)
    widget = HomeLayout();
  else widget = LoginScreen();
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required Widget this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}