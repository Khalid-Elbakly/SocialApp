class PostModel{
  String? name;
  String? uId;
  String? profileImage;
  String? postImage;
  String? postText;
  String? dateTime;


  PostModel({required this.name,required this.uId,required this.profileImage,required this.postImage,required this.postText,required this.dateTime});

  PostModel.fromJson(Map<String,dynamic> map){
    name = map['name'];
    uId = map['uId'];
    profileImage = map['profileImage'];
    postImage = map['postImage'];
    postText = map['postText'];
    dateTime = map['dateTime'];
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