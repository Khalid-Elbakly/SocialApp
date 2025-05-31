import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/message_model/message_model.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  userModel model;

  ChatDetailsScreen({super.key, required this.model});

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialAppCubit.get(context).getMessages(model.uId!);
      return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                title: Row(children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.profileImage}'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${model.name}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 15),
                  )
                ]),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: SocialAppCubit.get(context).messages.isNotEmpty,
                      builder:(context) => Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index) {
                              var message = SocialAppCubit.get(context).messages[index];
                              if(SocialAppCubit.get(context).user!.uId == message.senderId){
                               return buildMyMessage(message);
                              }
                             return buildMessage(message);
                            },
                            separatorBuilder: (context,index) => const SizedBox(height: 15,),
                            itemCount: SocialAppCubit.get(context).messages.length),
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                    const Spacer(),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter message here',
                              ),
                              controller: messageController,
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            child: IconButton(
                              icon: const Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                SocialAppCubit.get(context).sendMessage(
                                    text: messageController.text,
                                    receiverId: model.uId!,
                                    dateTime: DateTime.now().toString());
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      );
    });
  }
}

Widget buildMessage(MessageModel model) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10)),
            color: Colors.grey[300]),
        child: Text(
          model.text!,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
  );
}

Widget buildMyMessage(MessageModel model) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10)),
            color: Colors.blue[200]),
        child: Text(
          model.text!,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
  );
}
