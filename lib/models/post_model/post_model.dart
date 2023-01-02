class PostModel{
  String? name;
  String? uId;
  String? profileImage;
  String? postImage;
  String? postText;


  PostModel({required this.name,required this.uId,this.profileImage,this.postImage,this.postText});

  PostModel.fromJson(Map<String,dynamic> map){
    name = map['name'];
    uId = map['uId'];
    profileImage = map['profileImage'];
    postImage = map['postImage'];
    postText = map['postText'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'profileImage' : profileImage,
      'postImage' : postImage,
      'postText' : postText,
    };
  }
}