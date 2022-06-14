import 'package:flutter/material.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';
import 'package:musica_app/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'auto_playing_list/set_source.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({
    Key? key,
  }) : super(key: key);
    ValueNotifier <List<SongModel>> temp = ValueNotifier([]);
  @override
  Widget build(BuildContext context){
    FunctionsData.getfavList();
    FunctionsData.showsongs();
    return 
     Container(
      decoration: FunctionsData.themvalue==0  ? const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/music.jpg'),fit: BoxFit.cover)): 
       BoxDecoration( gradient:FunctionsData.themvalue==1 || FunctionsData.themvalue==null ?  const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 0, 0, 0),

                  Color.fromARGB(255, 0, 0, 0),
              
              ]) : const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 122, 0, 57),

                  Color.fromARGB(255, 11, 219, 226),
              
              ])),
      child: Padding(
      //  padding:EdgeInsets.all(0),
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15 ,bottom: MediaQuery.of(context).size.height*0.1),
        child: ValueListenableBuilder(
          valueListenable: FunctionsData.favsong,
          builder: (BuildContext ctx, List<SongModel> songList, Widget? child) {
            return ListView.builder(
                itemCount: songList.length,
            itemBuilder: (ctx, index)     {
                  return Padding(
                    padding:  EdgeInsets.all( MediaQuery.of(context).size.height*0.011),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1,color:const Color.fromARGB(255, 255, 255, 255)),color:const Color.fromARGB(0, 6, 6, 6).withOpacity(0.6)),
                      child: ListTile(
                        selectedTileColor:const Color.fromARGB(255, 226, 222, 222),                      
                        onTap: () {
                           NowPlaying.player.setAudioSource(
                                         SetSource.createPLaylist(songList),
                                         initialIndex: index,
                                       );
                                         NowPlaying.player.play();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => NowPlaying(
                                    songs: songList,
                                  )));
                        },
                        leading: CircleAvatar(child: QueryArtworkWidget(
                          id: songList[index].id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(0),
                        ),
                        ),
                        title: Text(
                          songList[index].title.replaceAll(RegExp('_'),''),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 232, 231, 232),
                              overflow: TextOverflow.ellipsis),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite),
                          color:FunctionsData.themvalue!= 2? const Color.fromARGB(255, 0, 255, 217):Colors.pink,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    backgroundColor:FunctionsData.themvalue!= 2?
                                    const    Color.fromARGB(255, 49, 49, 49): const Color.fromARGB(255, 48, 7, 20),
                                    title: const Text('Remove from favorite?',style: TextStyle(color: Color.fromARGB(255, 33, 243, 226)),),
                                    content: const Text(
                                        'the song will be permenantly removed  !!',style: TextStyle(color: Color.fromARGB(255, 115, 170, 180))),
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child:const Text('cancel',style: TextStyle(color: Color.fromARGB(255, 31, 207, 199)),)),
                                          TextButton(
                                              onPressed: () {
                                                FunctionsData.removeList(index);
                                                Navigator.pop(context);
                                              },
                                              child:const Text('Ok',style: TextStyle(color: Color.fromARGB(255, 31, 213, 219))))
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  );
                  
                });
          },
        ),
      ),
    );
  }
 
  }
  

