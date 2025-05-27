import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
    listener: (context,state) {},
      builder: (context,state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Create Post',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'POST',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1666499820~exp=1666500420~hmac=5fc2163ab8b833a6d7e4214f60d496f7259ed849c720fa31f109acc4c5aba77e'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Mody dody',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind,',
                        border: InputBorder.none),
                  ),
                ),
                if(SocialAppCubit.get(context).postImage != null)
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover ,
                            image: FileImage(SocialAppCubit.get(context).postImage!)
                          )
                        ),
                      ),
                      IconButton(onPressed: (){
                        SocialAppCubit.get(context).removeImage();
                      }, icon: Icon(Icons.close))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {
                        SocialAppCubit.get(context).pickPostImage();
                      }, child: Row(
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 10,),
                          Text('Add Photo')
                        ],
                      )),
                    ),
                    Expanded(child: TextButton(
                      child: Text('#Tags'), onPressed: () {},))
                  ],
                )
              ]),
            ));
      });
  }
}
