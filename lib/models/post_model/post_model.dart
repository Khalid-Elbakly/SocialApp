class PostModel{
  String? name;
  String? uId;
  String? profileImage;
  String? postImage;
  String? postText;
  String? dateTime;
  String? postId;
  int? likes;
  List? comments;


  PostModel({required this.name,required this.uId,required this.profileImage,required this.postImage,required this.postText,required this.dateTime});

  PostModel.fromJson(Map<String,dynamic> map,String id, List comm){
    name = map['name'];
    uId = map['uId'];
    profileImage = map['profileImage'];
    postImage = map['postImage'];
    postText = map['postText'];
    dateTime = map['dateTime'];
    postId = id;
    comments = comm;
  }


  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'profileImage' : profileImage,
      'postImage' : postImage,
      'postText' : postText,
      'dateTime' : dateTime,
    };
  }
}