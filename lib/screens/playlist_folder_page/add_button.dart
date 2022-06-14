import 'package:flutter/material.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/db/db_functions/playlist_functions.dart';

class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.song})
      : super(key: key);
  int? index;
  int? folderindex;
  int? song;
  List<dynamic> songslist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
    final checkindex = PlaylistFunctions
        .playlistsong.value[widget.folderindex!].dbsonglist
        .contains(widget.song);
    final indexcheck = PlaylistFunctions
        .playlistsong.value[widget.folderindex!].dbsonglist
        .indexWhere((element) => element ==widget.song);
    if (checkindex != true) {
      return IconButton(
          onPressed: () async {
            PlaylistFunctions.getplayList();
            widget.songslist.add(widget.song);
            PlaylistButton.updatelist = [
              widget.songslist,
              PlaylistFunctions
                  .playlistsong.value[widget.folderindex!].dbsonglist
            ].expand((element) => element).toList();
            final model = Playlistmodel(
              name: PlaylistFunctions
                  .playlistsong.value[widget.folderindex!].name,
              dbsonglist: PlaylistButton.updatelist,
              image: PlaylistFunctions
                  .playlistsong.value[widget.folderindex!].image,
            );
            await PlaylistFunctions.updatlist(widget.folderindex, model);
            setState(() {});
          },
          icon: const Icon(
            Icons.adjust_rounded,
            color: Color.fromARGB(255, 135, 255, 145),
          ));
    }
    return IconButton(
        onPressed: ()  {
          PlaylistFunctions.getplayList();
          PlaylistFunctions.playlistsong.value[widget.folderindex!].dbsonglist
              .removeAt(indexcheck);
          PlaylistButton.dltlist = [
            widget.songslist,
            PlaylistFunctions.playlistsong.value[widget.folderindex!].dbsonglist
          ].expand((element) => element).toList();
          final model = Playlistmodel(
              name: PlaylistFunctions
                  .playlistsong.value[widget.folderindex!].name,
              dbsonglist: PlaylistButton.dltlist,
              image: PlaylistFunctions
                  .playlistsong.value[widget.folderindex!].image);
           PlaylistFunctions.updatlist(widget.folderindex, model);
          setState(() {});
         
        },
        icon: Icon(
          Icons.adjust_rounded,
          color: Colors.red.shade200,
        ));
  }
}
