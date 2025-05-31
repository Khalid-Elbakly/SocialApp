class MessageModel {
  String? text;
  String? receiverId;
  String? senderId;
  String? dateTime;
  String? image;

  MessageModel({
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    this.image
  });

  MessageModel.fromJson(Map<String, dynamic> map) {
    text = map['text'];
    receiverId = map['receiverId'];
    senderId = map['senderId'];
    dateTime = map['dateTime'];
    image = map['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'image' : image
    };
  }
}
