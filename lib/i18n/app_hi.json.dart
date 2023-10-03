import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


// Initialize the YoutubePlayerController with your video ID.
YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: 'https://youtu.be/t_youSWoGp8',
  flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: false,
  ),
);

