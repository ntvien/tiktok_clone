import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(fireStore
        .collection("videos")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Video> retVal = [];
      for (var element in querySnapshot.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  likeVideo(String id)async{
    DocumentSnapshot snapshot = await fireStore.collection("videos").doc(id).get();
    var uid = authController.user!.uid;
    if((snapshot.data()! as dynamic)["likes"].contains(uid)){
      await fireStore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    }else{
      await fireStore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }

}
