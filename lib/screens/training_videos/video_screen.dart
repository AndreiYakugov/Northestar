import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For managing orientation
import 'package:northstar_app/screens/training_videos/full_screen_video.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../Models/video.dart';

class VideoScreen extends StatefulWidget {
  final Video videoData;

  const VideoScreen({super.key, required this.videoData});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;
  late Timer _hideControlTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoData.video_video)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlTimer.cancel();
    super.dispose();
  }

  // Hide the controls after 3 seconds of no interaction
  void _startHideControlTimer() {
    _hideControlTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  // Toggle visibility of controls on tap
  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      _startHideControlTimer(); // Reset the timer if controls are shown
    }
  }

  // Navigate to full screen view and switch to landscape mode
  void _goFullScreen(BuildContext context) {
    // Set landscape mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(controller: _controller),
      ),
    ).then((_) {
      // Restore portrait mode after full-screen
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.videoData.video_title)),
      body: _controller.value.isInitialized
          ? Column(
              children: [
                GestureDetector(
                  onTap: _toggleControlsVisibility,
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      if (_showControls)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(
                                _isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                color: Colors.white,
                                size: 60,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                    _isPlaying = false;
                                  } else {
                                    _controller.play();
                                    _isPlaying = true;
                                  }
                                });
                                _startHideControlTimer();
                              },
                            ),
                          ),
                        ),
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              _goFullScreen(
                                  context); // Navigate to full-screen mode
                            },
                          ),
                        ),
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                                playedColor: AppColors.primaryColor),
                          ),
                        )
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    widget.videoData.video_description,
                    style: TextStyle(color: Colors.white),
                  ),
                ))
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
