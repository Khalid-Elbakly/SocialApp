import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/modules/login/login_screen.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'uId');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ))
            ],
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              if (!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(
                  color: Colors.amber.withOpacity(0.6),
                  width: double.infinity,
                  // height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Please verify your email'),
                      SizedBox(
                        width: 15,
                      ),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then((value) => Fluttertoast.showToast(
                                    msg: 'Check Your Mail',
                                    backgroundColor: Colors.green));
                          },
                          child: Text('SEND'))
                    ],
                  ),
                ),
              Expanded(child: Padding(padding: EdgeInsets.only(top: 10),child: cubit.screens[cubit.currentIndex]))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              cubit.changeBottomNav(index, context);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'settings'),
            ],
          ),
        );
      },
    );
  }
}
