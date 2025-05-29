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

        var cubit = SocialAppCubit.get(context);

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
                    onPressed: () {
                      cubit.uploadPostImage(dateTime: DateTime.now().toString(),
                          postText: postController.text);
                    },
                    child: Text(
                      'POST',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
               if (state is UploadPostLoading)
                const LinearProgressIndicator(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            cubit.user!.profileImage!
                          ),),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          cubit.user!.name!,
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
                        cubit.removeImage();
                      }, icon: const CircleAvatar(
                          child: Icon(Icons.close,color: Colors.white,)))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {
                        cubit.pickPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
