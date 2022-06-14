
import 'package:flutter/material.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';
import 'package:musica_app/screens/home_page.dart';
import 'package:musica_app/screens/playlist_folder_page/add_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../db/db_functions/playlist_functions.dart';

class PlaylistAdd extends StatelessWidget {
   PlaylistAdd({ Key? key,this.newindex }) : super(key: key);
  dynamic newindex;
  @override
  Widget build(BuildContext context) {
   PlaylistFunctions.getplayList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          decoration: FunctionsData.themvalue==0  ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/music.jpg'),fit: BoxFit.cover)):
                       BoxDecoration( gradient:FunctionsData.themvalue==1 || FunctionsData.themvalue==null  ?  const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 0, 0, 0),

                  Color.fromARGB(255, 0, 0, 0),
              
              ]) : const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 122, 0, 57),

                  Color.fromARGB(255, 11, 219, 226),
              
              ])),
          child: ListView.builder(
              itemCount: HomePage.songs.length,
              itemBuilder: (ctx, index) {
                return Card(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: QueryArtworkWidget(
                          id: HomePage.songs[index].id,
                          type: ArtworkType.AUDIO,artworkBorder: BorderRadius.circular(0),),
                    ),
                    title: Text(
                      HomePage.songs[index].title.replaceAll(RegExp('_'),'').replaceAll(RegExp('-'),''),
                      style: const TextStyle(overflow: TextOverflow.ellipsis,color: Colors.white),
                    ),
                     trailing:
                    PlaylistButton(
                     song:HomePage.songs[index].id,
                     index: index,
                     folderindex: newindex,
                  ),
                  ),
                );
              })),
    );
  }
}

