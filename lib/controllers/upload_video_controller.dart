import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:video_compress/video_compress.dart';

import '../models/video.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video
  upLoadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await fireStore.collection("users").doc(uid).get();
      //get id
      var allDocs = await fireStore.collection("videos").get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);
      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)["name"],
        uid: uid,
        id: "Video $len",
        likes: [],
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)["profilePhoto"],
        thumbnail: thumbnail,
        commentCount: 0,
      );

      await fireStore
          .collection("videos")
          .doc("Video $len")
          .set(video.toJson());

      Get.back();
    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }
}
