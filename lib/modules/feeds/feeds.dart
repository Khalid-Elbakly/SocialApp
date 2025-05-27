import 'package:flutter/material.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                itemBuilder: (context, index) => buildPostItem(context),
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: 10),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

Widget buildPostItem(context) {
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
                    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1666499820~exp=1666500420~hmac=5fc2163ab8b833a6d7e4214f60d496f7259ed849c720fa31f109acc4c5aba77e'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mody dody',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 15),
                    ),
                    Text(
                      'January 21, 2022 at 11:00 pm',
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
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
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
        Image(
            image: NetworkImage(
                'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1666503688~exp=1666504288~hmac=862088eb93939ae2b64f15476bcb08a88730858d0a0bf78de96e658380135b50')),
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
                    Text('1200'),
                  ],
                ),
              ),
            )),
            Expanded(
                child: InkWell(
                    onTap: () {},
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
                          Text('350 Comment'),
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
                  child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1666499820~exp=1666500420~hmac=5fc2163ab8b833a6d7e4214f60d496f7259ed849c720fa31f109acc4c5aba77e'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Write a comment...',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              )),
              InkWell(
                onTap: () {},
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
