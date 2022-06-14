import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';
import 'package:musica_app/db/db_functions/playlist_functions.dart';
import 'package:musica_app/favoritebutton/favbutton.dart';
import 'screens/splash_screen.dart';


void main() async{

  //=======landscap rotation lock=========//
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  //===============================////////////////////=====================================//
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(PlaylistmodelAdapter().typeId))
  {
   Hive.registerAdapter(PlaylistmodelAdapter()); 
  }
 await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  FavButton();
  FunctionsData.getfavList();
  PlaylistFunctions.getplayList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: GetSplash(),
    debugShowCheckedModeBanner: false ,
    );
  }
}

