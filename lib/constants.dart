import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/views/screens/add_video_screen.dart';
import 'package:tiktok/views/screens/video_screen.dart';

List pages = [
  VideoScreen(),
  Text("Search Screen"),
  const AddVideoScreen(),
  Text("Message Screen"),
  Text("Profile Screen"),
];

// COLORS
const backgroundColor = Colors.black;
const borderColor = Colors.grey;
var buttonColor = Colors.red[400];

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

//CONTROLLER
var authController = AuthController.instance;