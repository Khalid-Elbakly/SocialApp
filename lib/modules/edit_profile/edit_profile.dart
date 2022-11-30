import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
        builder: (context, state) {
          var model = SocialAppCubit.get(context).userModel;
          var cubit = SocialAppCubit.get(context);

          nameController.text = '${model!.name}';
          bioController.text = '${model.bio}';
          phoneController.text = '${model.phone}';

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                TextButton(onPressed: (){
                  SocialAppCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                }, child: Text('UPDATE'))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is SocialAppLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    Container(
                      height: 220,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                    height: 140,
                                    width: double.infinity,
                                    child: Image(
                                      image: SocialAppCubit.get(context)
                                                  .coverImage ==
                                              null
                                          ? NetworkImage(
                                              '${model.coverImage}',
                                            )
                                          : FileImage(SocialAppCubit.get(context)
                                              .coverImage!) as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialAppCubit.get(context).pickCoverImage();
                                  },
                                  icon: Icon(IconBroken.Camera))
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              CircleAvatar(
                                radius: 62,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    SocialAppCubit.get(context).profileImage ==
                                            null
                                        ? NetworkImage('${model.profileImage}')
                                        : FileImage(SocialAppCubit.get(context)
                                            .profileImage!) as ImageProvider,
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialAppCubit.get(context)
                                        .pickProfileImage();
                                  },
                                  icon: Icon(IconBroken.Camera))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if(cubit.coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: MaterialButton(onPressed: (){
                                    cubit.uplaodCoverImage(name: nameController.text,bio: bioController.text,phone: phoneController.text);
                                  },child: Text('Upload Cover Image'),color: Colors.blue,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        if(cubit.profileImage != null)
                        Expanded(child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: MaterialButton(onPressed: (){
                                cubit.uplaodProfileImage(name: nameController.text,bio: bioController.text,phone: phoneController.text);
                              },child: Text('Upload Profile Image'),color: Colors.blue,),
                            ),
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bioController,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
