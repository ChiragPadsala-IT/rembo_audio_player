import 'package:audio_player/screen/audio_home_page.dart';
import 'package:audio_player/screen/audio_play_page.dart';
import 'package:flutter/material.dart';

void main(){
  return runApp(AudioApp());
}

class AudioApp extends StatefulWidget {
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => AudioHomePage(),
        "/audio_play_page" : (context) => AudioPlayPage(),
      },
    );
  }
}
