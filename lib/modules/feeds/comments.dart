import 'package:flutter/material.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/models/post_model/post_model.dart';

class Comments extends StatelessWidget {
  final int no;
  const Comments({super.key,required this.no});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => buildCommentItem(
                SocialAppCubit.get(context).posts[no], context,index),
            separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
            itemCount: SocialAppCubit.get(context).posts[no].comments!.length),
      ),
    );
  }
}

Widget buildCommentItem(PostModel model,context,index) {
  return Card(
      child: Column(

        children: [
          Row(
              children: [
    CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage('${model.comments![index]['profileImage']}'),
    ),
    SizedBox(
          width: 15,
    ),
    Text(
      '${model.comments![index]['name']}',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
    )
  ]),
          Text(model.comments![index]['comment'])
        ],
      ));
}
