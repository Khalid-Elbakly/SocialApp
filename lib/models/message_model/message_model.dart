class MessageModel{
  String? text;
  String? receiverId;
  String? senderId;
  String? dateTime;


  MessageModel({required this.text,required this.senderId,required this.receiverId,required this.dateTime,});

  MessageModel.fromJson(Map<String,dynamic> map){
    text = map['text'];
    receiverId = map['receiverId'];
    senderId = map['senderId'];
    dateTime = map['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'text' : text,
      'receiverId' : receiverId,
      'senderId' : senderId,
      'dateTime' : dateTime,
      };
  }
}