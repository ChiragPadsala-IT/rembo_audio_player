import 'package:audio_player/moduls/audio_url.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioHomePage extends StatefulWidget {
  @override
  _AudioHomePageState createState() => _AudioHomePageState();
}

class _AudioHomePageState extends State<AudioHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Song List",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.network("https://i.pinimg.com/564x/00/eb/12/00eb128c395c291d04c9244e16828d74.jpg",fit: BoxFit.fitHeight,colorBlendMode: BlendMode.lighten,),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0,bottom: 10.0),
              child: ListView.separated(
                itemCount: myAudio.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: myAudio[index].color,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed("/audio_play_page",
                          arguments: index,
                        );
                      },
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(myAudio[index].imageUrl),
                      ),
                      title: Text(myAudio[index].tital),
                      subtitle: Text("New song"),
                      trailing: Icon(Icons.play_arrow,color: CupertinoColors.label,),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
