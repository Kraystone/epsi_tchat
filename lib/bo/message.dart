import 'package:epsi_tchat/bo/user.dart';

class Message{
  String content;
  User author;
  bool isImage;
  DateTime creaded_at;

  Message(this.content, this.author, this.isImage, this.creaded_at);

  Message.fromJson(Map<String, dynamic>json):
      content = json["content"],
        author = User.fromJson(json["author"]),
        isImage = json["isImage"],
        creaded_at = json["creaded_at"];

  Map<String, dynamic> toJson() => {
    "content": content,
    "author": author,
    "isImage": isImage,
    "creaded_at" : creaded_at
  };
}