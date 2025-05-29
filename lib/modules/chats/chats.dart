import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/user_model/user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialAppCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialAppCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: SocialAppCubit.get(context).users.length),
            fallback: (context) => const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget buildChatItem(userModel model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage('${model.profileImage}'),
      ),
      const SizedBox(
        width: 15,
      ),
      Text(
        '${model.name}',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
      )
    ]),
  );
}
