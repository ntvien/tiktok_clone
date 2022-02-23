import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';

import '../models/user.dart';

class SearchController extends GetxController{
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async{
    _searchedUsers.bindStream(fireStore.collection("users").where("name", isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot querySnapshot){
      List<User> retVal =[];
      for(var element in querySnapshot.docs){
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}