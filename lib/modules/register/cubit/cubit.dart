import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/data_model/data_model.dart';
import 'package:socialapp/modules/register/cubit/states.dart';
import 'package:socialapp/shared/network/endpoints.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterIntialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(name, email, password, phone) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      print(value.user!.email);
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    dataModel user = dataModel(
        name: name,
        uId: uId,
        email: email,
        phone: phone,
        profileImage:
            'https://img.freepik.com/free-vector/organic-flat-coronavirus-facebook-frame_23-2148928531.jpg?w=740&t=st=1668601592~exp=1668602192~hmac=4a6b751d0aa5a8867f5a4c3c10825a4a9291e7a28e2fa604f50ac19cbf16db3a',
        coverImage:
            'https://img.freepik.com/free-vector/nautical-realistic-blue-background-with-jumping-whale-sea-water-illuminated-by-sunlight-vector-illustration_1284-77450.jpg?w=996&t=st=1668601744~exp=1668602344~hmac=b8ca0d8cbc5d4af60ba9ff4a6c91486f78d2e9c9c7afd9d8122f4e2627b59f0e',
        bio: 'bio...');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      CacheHelper.setData(key: 'uId', value: uId);
      uID = uId;
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState(error));
    });
  }

  bool isPassword = true;
  Icon suffixIcon = Icon(Icons.visibility_off_outlined);

  ChangePasswordVisibality() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility_outlined);
    emit(RegisterPasswordVisibaltiy());
  }
}
