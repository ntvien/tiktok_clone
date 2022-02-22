import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.thumbnail,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "songName": songName,
        "caption": caption,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Video(
        username: snapShot["username"],
        uid: snapShot["uid"],
        id: snapShot["id"],
        likes: snapShot["likes"],
        songName: snapShot["songName"],
        caption: snapShot["caption"],
        commentCount: snapShot["commentCount"],
        shareCount: snapShot["shareCount"],
        videoUrl: snapShot["videoUrl"],
        thumbnail: snapShot["thumbnail"],
        profilePhoto: snapShot["profilePhoto"]);
  }
}
