import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<loginStates> {
  LoginCubit() : super(loginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin(email, password) {
    emit(loginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          emit(loginSuccessState(value.user!.uid));
          print(value.user!.email);
    }).catchError((error) {
      print(error);
      emit(loginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  Icon suffixIcon = Icon(Icons.visibility_off_outlined);

  ChangePasswordVisibality(){
    isPassword = !isPassword;
    suffixIcon = isPassword? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined);
    emit(loginPasswordVisibaltiy());
  }
}
