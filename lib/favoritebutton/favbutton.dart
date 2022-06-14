import 'package:flutter/material.dart';
import 'package:musica_app/db/db_functions/db_functions.dart';

class FavButton extends StatefulWidget {
   FavButton({ Key? key, this.id, }) : super(key: key);
   
  dynamic id; 
  @override

  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
 final findindex = FunctionsData.dblist.contains(widget.id);
 final indexcheck = FunctionsData.dblist.indexWhere((element) =>element == widget.id);
 if(findindex == true){
  return IconButton(onPressed:(){
   FunctionsData.removeList(indexcheck);
  setState(() {});
  }, icon: Icon(Icons.favorite,color:FunctionsData.themvalue!= 2 ? const Color.fromARGB(255, 0, 255, 208):const Color.fromARGB(255, 195, 12, 85),));
  }
      return IconButton(onPressed: ()async{
     await FunctionsData.addfavsong(widget.id);
      setState(() {});
    }, icon: Icon(Icons.favorite_border_outlined,color:FunctionsData.themvalue!=2 ? const Color.fromARGB(255, 21, 143, 145):const Color.fromARGB(255, 22, 16, 70)));
   }
}