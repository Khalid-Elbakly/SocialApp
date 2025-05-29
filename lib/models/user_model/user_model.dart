class userModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? profileImage;
  String? coverImage;
  String? bio;

  userModel({required this.name,required this.uId,required this.email,required this.phone,this.profileImage,this.coverImage,this.bio});

  userModel.fromJson(Map<String,dynamic> map){
    email = map['email'];
    name = map['name'];
    phone = map['phone'];
    uId = map['uId'];
    profileImage = map['profileImage'];
    coverImage = map['coverImage'];
    bio = map['bio'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'profileImage' : profileImage,
      'coverImage' : coverImage,
      'bio' : bio,
    };
  }
}