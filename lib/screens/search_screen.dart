import 'package:flutter/material.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';
import 'package:musica_app/screens/home_page.dart';
import 'package:musica_app/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'auto_playing_list/set_source.dart';
 
class SearchScreen extends StatelessWidget {

  SearchScreen({ Key? key }) : super(key: key);

   ValueNotifier <List<SongModel>> temp = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
            return 
                  Container(
                    decoration: FunctionsData.themvalue == 0  ? const BoxDecoration(image:
                     DecorationImage(image: AssetImage('assets/images/music.jpg',),fit:BoxFit.cover )): 
                       BoxDecoration( gradient:FunctionsData.themvalue==1 || FunctionsData.themvalue==null ?  const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 0, 0, 0),

                  Color.fromARGB(255, 0, 0, 0),
              
              ]) : const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 122, 0, 57),

                  Color.fromARGB(255, 11, 219, 226),
              
              ])),
                  child: ListView(
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(30),
                          child:  TextField(
                            onTap: (){},
                            onChanged: (String?  value){
                              if(value == null || value.isEmpty){
                                temp.value.addAll(HomePage.songs);
                              }
                              temp.value.clear();
                              for (SongModel i  in HomePage.songs ) {
                                if(i.title.toLowerCase().contains(value!.toLowerCase())){
                                  temp.value.add(i);
                                } 
                                temp.notifyListeners();
                              }
                            },
                            controller: searchController,
                            decoration: InputDecoration(hintText: 'Search here',
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(25),     
                           ),
                           prefixIcon:const Icon(Icons.search,color: Colors.black,),
                           filled: true,
                            errorBorder: InputBorder.none,
                            fillColor: Colors.white,
                          ),                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.6,
                          child: ValueListenableBuilder(
                            valueListenable: temp,
                             builder: (BuildContext ctx, List<SongModel> searchData, Widget? chld ){
                               return ListView.builder(itemBuilder: (ctx, index){
                                 final data=searchData[index];
                                 return ListTile(
                                   onTap: (){
                                      NowPlaying.player.setAudioSource(
                                          SetSource.createPLaylist(searchData),
                                          initialIndex: index,                                          
                                        );
                                        NowPlaying.player.play();
                                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> NowPlaying(songs: searchData)));
                                   },
                                   title: Text(data.title,style:const TextStyle( color: Colors.white),overflow: TextOverflow.ellipsis,),
                                   leading: CircleAvatar(child: QueryArtworkWidget(id: data.id, type: ArtworkType.AUDIO,artworkBorder: BorderRadius.circular(0),)),
                                 );
                               },
                               itemCount: searchData.length,                           
                               );}
                             ),
                        ),
                      )
                    ],
                  ),
                  );
  }
}