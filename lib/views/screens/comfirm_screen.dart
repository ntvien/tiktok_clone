import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/upload_video_controller.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController _controller;

  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.file(widget.videoFile);
    });
    _controller.initialize();
    _controller.play();
    _controller.setVolume(1);
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(_controller),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _songNameController,
                      labelText: "Song Name",
                      icon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      labelText: "Caption",
                      icon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => uploadVideoController.upLoadVideo(
                        _songNameController.text,
                        _captionController.text,
                        widget.videoPath),
                    child: Text(
                      "Share!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
