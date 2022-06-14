import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';
import 'package:musica_app/screens/home_page.dart';
import 'package:musica_app/screens/now_playing.dart';
import 'package:musica_app/screens/playlist_folder_page/add_button.dart';
import 'package:musica_app/screens/playlist_folder_page/playlist_addsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../db/db_functions/playlist_functions.dart';
import '../auto_playing_list/set_source.dart';

class PlaylistFolder extends StatefulWidget {
  PlaylistFolder({
    Key? key,
    this.newindex,
  }) : super(key: key);
  int? newindex;
  @override
  State<PlaylistFolder> createState() => _PlaylistFolderState();
}

class _PlaylistFolderState extends State<PlaylistFolder> {
  @override
  Widget build(BuildContext context) {
    PlaylistsongCheck.showselectsong(widget.newindex);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Center(
            child: Text(
          PlaylistFunctions.playlistsong.value[widget.newindex!].name
              .toString()
              .toUpperCase(),
          style: const TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontFamily: 'cursive',
              fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlaylistAdd(
                          newindex: widget.newindex,
                        )));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: FunctionsData.themvalue == 0
            ? BoxDecoration(
                image: PlaylistFunctions
                            .playlistsong.value[widget.newindex!].image !=
                        null
                    ? DecorationImage(
                        image: FileImage(File(PlaylistFunctions
                            .playlistsong.value[widget.newindex!].image!)),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage('assets/images/music.jpg'),
                        fit: BoxFit.cover))
            : BoxDecoration(
                image: PlaylistFunctions
                            .playlistsong.value[widget.newindex!].image !=
                        null
                    ? DecorationImage(
                        image: FileImage(File(PlaylistFunctions
                            .playlistsong.value[widget.newindex!].image!)),
                        fit: BoxFit.cover)
                    : null,
                gradient: FunctionsData.themvalue == 1 ||
                        FunctionsData.themvalue == null
                    ? const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 0, 0, 0),
                          ])
                    : const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: [
                            Color.fromARGB(255, 122, 0, 57),
                            Color.fromARGB(255, 11, 219, 226),
                          ])),
        child: ListView(
          children: [
            PlaylistFunctions
                    .playlistsong.value[widget.newindex!].dbsonglist.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text(
                        'Add Songs',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      child: ValueListenableBuilder(
                          valueListenable: PlaylistFunctions.playlistsong,
                          builder: (BuildContext ctx,
                              List<dynamic> selectedsongs, Widget? child) {
                            return ListView.builder(
                                itemCount: PlaylistFunctions.playlistsong
                                    .value[widget.newindex!].dbsonglist.length,
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  FunctionsData.themvalue != 2
                                                      ? const Color.fromARGB(
                                                          255, 44, 44, 44)
                                                      : const Color.fromARGB(
                                                          255, 80, 39, 52),
                                              title: const Text(
                                                'Delete song ?',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 62, 221, 239)),
                                              ),
                                              actions: [
                                                Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      33,
                                                                      222,
                                                                      243)),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          PlaylistFunctions
                                                              .getplayList();
                                                          PlaylistFunctions
                                                              .playlistsong
                                                              .value[widget
                                                                  .newindex!]
                                                              .dbsonglist
                                                              .removeAt(index);
                                                          PlaylistButton
                                                              .dltlist = [
                                                            PlaylistFunctions
                                                                .playlistsong
                                                                .value[widget
                                                                    .newindex!]
                                                                .dbsonglist
                                                          ]
                                                              .expand(
                                                                  (element) =>
                                                                      element)
                                                              .toList();
                                                          final model = Playlistmodel(
                                                              name: PlaylistFunctions
                                                                  .playlistsong
                                                                  .value[widget
                                                                      .newindex!]
                                                                  .name,
                                                              dbsonglist:
                                                                  PlaylistButton
                                                                      .dltlist,
                                                              image: PlaylistFunctions
                                                                  .playlistsong
                                                                  .value[widget
                                                                      .newindex!]
                                                                  .image);
                                                          PlaylistFunctions
                                                              .updatlist(
                                                                  widget
                                                                      .newindex,
                                                                  model);
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Ok',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        33,
                                                                        222,
                                                                        243))))
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: Card(
                                        color: Colors.white24,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                          child: ListTile(
                                            onTap: () {
                                              NowPlaying.player.setAudioSource(
                                                SetSource.createPLaylist(
                                                    PlaylistFunctions
                                                        .playsongmodel.value),
                                                initialIndex: index,
                                              );
                                              NowPlaying.player.play();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (ctx) => NowPlaying(
                                                                songs: PlaylistFunctions
                                                                    .playsongmodel
                                                                    .value,
                                                              )));
                                            },
                                            leading: CircleAvatar(
                                              child: QueryArtworkWidget(
                                                id: HomePage
                                                    .songs[PlaylistsongCheck
                                                        .selectplaysong
                                                        .value[index]]
                                                    .id,
                                                type: ArtworkType.AUDIO,
                                                artworkBorder:
                                                    BorderRadius.circular(0),
                                              ),
                                            ),
                                            title: Text(
                                              HomePage
                                                  .songs[PlaylistsongCheck
                                                      .selectplaysong
                                                      .value[index]]
                                                  .title
                                                  .replaceAll(RegExp('_'), '')
                                                  .replaceAll(RegExp('-'), ''),
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                          ),
                                        )),
                                  );
                                });
                          }),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            setState(() {});
          },
          icon: const Icon(
            Icons.rotate_left_outlined,
            color: Color.fromARGB(255, 233, 233, 233),
          )),
    );
  }
}
