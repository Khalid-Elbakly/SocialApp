import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/home_layout.dart';
import 'package:socialapp/modules/register/cubit/cubit.dart';
import 'package:socialapp/modules/register/cubit/states.dart';

import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCortroller = TextEditingController();
    TextEditingController nameCortroller = TextEditingController();
    TextEditingController phoneCortroller = TextEditingController();
    TextEditingController passwordCortroller = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state) {
          if(state is UserCreateSuccessState)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout()));
          else if(state is RegisterErrorState){
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
                          'Register',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: nameCortroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter User Name';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                width: 10)),
                            labelText: 'User Name',
                          ),
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
                          obscureText: RegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined,size: 20,),
                            suffixIcon:IconButton(onPressed: (){
                              RegisterCubit.get(context).ChangePasswordVisibality();
                            },icon: RegisterCubit.get(context).suffixIcon),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                width: 10)),
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: phoneCortroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Phone Number';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(borderSide: BorderSide(
                                width: 10)),
                            labelText: 'Phone Number',
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(
                          child: ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(nameCortroller.text,emailCortroller.text,passwordCortroller.text,phoneCortroller.text);
                              }
                            }, child: Text('REGISTER')),
                          ),
                           fallback: (context) => CircularProgressIndicator(),)
                        ),
                        SizedBox(height: 15,),
                          ],),
                        ),
                    ),
                  ),
                ),
          );
        }),
    );
  }
}
