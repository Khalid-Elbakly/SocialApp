import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/data_model/data_model.dart';
import 'package:socialapp/modules/chats/chats.dart';
import 'package:socialapp/modules/feeds/feeds.dart';
import 'package:socialapp/modules/new_post/new_post.dart';
import 'package:socialapp/modules/settings/settings.dart';
import 'package:socialapp/modules/users/users.dart';
import 'package:socialapp/shared/network/endpoints.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppIntialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  dataModel? userModel;

  void getUserData() {
    emit(SocialAppLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      emit(SocialAppSuccessState());
      userModel = dataModel.fromJson(value.data()!);
      print(userModel);
    }).catchError((error) {
      emit(SocialAppErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> title = ['News Feed', 'Chats', 'New Post', 'Users', 'Settings'];

  void changeBottomNav(index, context) {
    if (index == 2)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewPostScreen()));
    else
      currentIndex = index;
    emit(SocialBottomNavBarState());
  }

  final ImagePicker _picker = ImagePicker();
  File? profileImage;

  Future pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null)
      return;
    else {
      final imageTemp = File(image.path);
      profileImage = imageTemp;
      emit(SocialImagePirckerState());
    }
  }

  File? coverImage;

  Future pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null)
      return;
    else {
      final imageTemp = File(image.path);
      coverImage = imageTemp;
      emit(SocialImagePirckerState());
    }
  }

  void uplaodProfileImage({required name, required phone, required bio}) {
    emit(SocialAppLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              updateUser(name: name, phone: phone, bio: bio,profileImage: value);
            }).catchError((error) {
              emit(UploadProfileImageError());
              print(error);
            }))
        .catchError((error) {
      emit(UploadProfileImageError());
      print(error);
    });
  }

  void uplaodCoverImage({required name, required phone, required bio}) {
    emit(SocialAppLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              updateUser(name: name, phone: phone, bio: bio,coverImage: value);
            }).catchError((error) {
              emit(UploadCoverImageError());
              print(error);
            }))
        .catchError((error) {
      emit(UploadCoverImageError());
      print(error);
    });
  }

  void updateUser({required name, required phone, required bio,profileImage,coverImage}) {
    dataModel model = dataModel(
        name: name,
        uId: userModel!.uId,
        email: userModel!.email,
        phone: phone,
        profileImage: profileImage??userModel!.profileImage,
        coverImage: coverImage??userModel!.coverImage,
        bio: bio);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) => getUserData())
        .catchError((error) {
      emit(SocialAppErrorState(error));
    });
  }
}
