import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/post_model/post_model.dart';
import 'package:socialapp/modules/feeds/comments.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SocialAppCubit,SocialAppStates>(
        listener: (context,state) {},
        builder: (context,state) => ConditionalBuilder(
          condition: SocialAppCubit.get(context).posts.isNotEmpty,
          builder:(context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?w=1060&t=st=1666495939~exp=1666496539~hmac=9bd9e91bf02bc8c3f80908f73ea40f187bb7b7a0b7acb690af3589096541939e'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ],
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildPostItem(SocialAppCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    itemCount: SocialAppCubit.get(context).posts.length),
                SizedBox(height: 10,)
              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

Widget buildPostItem(PostModel model,context,index) {

  return Card(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.profileImage}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 15),
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(IconBroken.More_Circle),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Container(
            color: Colors.grey[300],
            height: 1,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${model.postText}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        // Container(
        // height: 20,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              Container(
                  height: 25,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      '#Software',
                      style: TextStyle(color: Colors.blue),
                    ),
                    height: 2,
                    minWidth: 10,
                    padding: EdgeInsetsDirectional.only(end: 5),
                  )),
              Container(
                  height: 25,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      '#flutter',
                      style: TextStyle(color: Colors.blue),
                    ),
                    height: 2,
                    minWidth: 1,
                    padding: EdgeInsetsDirectional.only(end: 5),
                  )),
            ],
          ),
        ),
        if(model.postImage != '')
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: NetworkImage(
                  '${model.postImage}')),
        ),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${SocialAppCubit.get(context).likes[index]} Likes'),
                  ],
                ),
              ),
            )),
            Expanded(
                child: InkWell(
                    onTap: () {
                      //print(SocialAppCubit.get(context).posts[index].comments!.length);
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => Comments(no: index,)));
                    showBottomSheet(context: context, builder: (context) => Comments(no: index,),constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if(model.comments!.isNotEmpty)
                          Text('${model.comments!.length} Comment'),
                        ],
                      ),
                    )))
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Container(
            color: Colors.grey[300],
            height: 1,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            '${SocialAppCubit.get(context).user!.profileImage}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText:                         'Write a comment...',
                          ),
                          onFieldSubmitted: (s){
                            SocialAppCubit.get(context).commentPost(model.postId, s);
                          },
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  )),
              InkWell(
                onTap: () {
                  SocialAppCubit.get(context).likePost(model.postId);
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("LIKE")
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
