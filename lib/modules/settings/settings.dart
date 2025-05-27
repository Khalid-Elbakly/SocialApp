import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/modules/edit_profile/edit_profile.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(builder: (context,state){
      var model = SocialAppCubit.get(context).userModel;
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          child: Image(
                            image: NetworkImage('${model!.coverImage}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${model.profileImage}'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text('${model.name}',style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 10,),
                Text('${model.bio}',style: Theme.of(context).textTheme.caption),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText1,),
                            Text('Posts'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText1,),
                            Text('Posts'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText1,),
                            Text('Posts'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.bodyText1,),
                            Text('Posts'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(child: MaterialButton(onPressed: (){},child: Text('Add Photos'),)),
                    SizedBox(width: 5,),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                    }, icon: Icon(IconBroken.Edit))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
