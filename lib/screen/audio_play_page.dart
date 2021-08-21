import 'package:audio_player/moduls/audio_url.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AudioPlayPage extends StatefulWidget {
  @override
  _AudioPlayPageState createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  int durationsecond;
  int positionsecond = 0;
  Duration duration;
  Duration position;
  bool isplay = false;
  bool ispause = false;
  bool isVolumn = true;

  playhandler(index) async {
    if (isplay == false) {
      _audioPlayer = await _audioCache.play(myAudio[index].audioUrl);
      setState(() {
        duration = Duration(seconds: 0, minutes: 0);
        position = Duration(seconds: 0, minutes: 0);
        isplay = true;
        ispause = true;
      });
    } else {
      if (ispause == true) {
        _audioPlayer.pause();
        setState(() {
          ispause = false;
        });
      } else {
        _audioPlayer.resume();
        setState(() {
          ispause = true;
        });
      }
    }

    _audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
        durationsecond = duration.inSeconds;
        while(durationsecond >= 60){
          durationsecond-=60;
        }
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
        positionsecond = position.inSeconds;
        while(positionsecond>=60){
          positionsecond-=60;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings s = ModalRoute.of(context).settings;
    int index = s.arguments;

    myalert(){
      return Alert(
        context: context,
        title: "warning",
        content: Text("Are sure for exit ?"),
        buttons: [
          DialogButton(
              child: Text("Yes"),
              onPressed: () {
                _audioPlayer.dispose();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              }),
          DialogButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ).show();
    }

    return WillPopScope(
      onWillPop: () {
        return myalert();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image(
                  image: NetworkImage(myAudio[index].imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black54,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            myAudio[index].imageUrl,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      myAudio[index].tital,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      myAudio[index].singer,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.stop),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {
                            setState(() {
                              _audioPlayer.stop();
                              position = Duration(seconds: 0);
                              ispause = false;
                              isplay = false;
                            });
                          },
                        ),
                        IconButton(
                          icon: (ispause == true)
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {
                            playhandler(index);
                          },
                        ),
                        IconButton(
                          icon: isVolumn
                              ? Icon(Icons.headset)
                              : Icon(Icons.headset_off),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {
                            if(isVolumn){
                              _audioPlayer.setVolume(0);
                              setState(() {
                                isVolumn = false;
                              });
                            }else{
                              _audioPlayer.setVolume(1);
                              setState(() {
                                isVolumn = true;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Slider(
                      value: isplay ? position.inSeconds.toDouble() : 0,
                      min: 0,
                      max: (isplay) ? duration.inSeconds.toDouble() : 0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          position = Duration(seconds: val.toInt());
                          _audioPlayer.seek(position);
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (isplay)
                            ? Text(
                                position?.inMinutes.toString() +
                                    " : " +
                                    positionsecond.toString() +
                                    "\t/\t" +
                                    duration?.inMinutes.toString() +
                                    " : " +
                                    durationsecond.toString(),
                                style: TextStyle(color: Colors.white),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.white,size: 34,),
                    onPressed: () {
                      myalert();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
