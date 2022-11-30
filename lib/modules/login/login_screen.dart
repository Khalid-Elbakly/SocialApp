import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/home_layout.dart';
import 'package:socialapp/modules/login/cubit/cubit.dart';
import 'package:socialapp/modules/login/cubit/states.dart';

import '../../shared/network/endpoints.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCortroller = TextEditingController();
    TextEditingController passwordCortroller = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,loginStates>(
        listener: (context,state) {
          if(state is loginSuccessState){
            CacheHelper.setData(key: 'uId', value: state.uid);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout()));
          }
          else if(state is loginErrorState){
              Fluttertoast.showToast(msg: state.error,backgroundColor: Colors.red);
            }
          },

        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: emailCortroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email Address';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                width: 10)),
                            labelText: 'Email Address',
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: passwordCortroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined,size: 20,),
                            suffixIcon:IconButton(onPressed: (){
                              LoginCubit.get(context).ChangePasswordVisibality();
                            },icon: LoginCubit.get(context).suffixIcon),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                width: 10)),
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: ConditionalBuilder(
                          condition: state is! loginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(emailCortroller.text,passwordCortroller.text);
                              }
                            }, child: Text('LOGIN')),
                          ),
                           fallback: (context) => CircularProgressIndicator(),)
                        ),
                        SizedBox(height: 15,),
                        Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Text('Don\'t have an account?'),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                            }, child: Text('Register Now'),)
                          ],),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
    );
  }
}
