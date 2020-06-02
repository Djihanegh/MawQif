import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Vehicule extends StatefulWidget  {
   static String title = "petit,moyen .." ;
  createState() {
    return VehiculeState();
  }


}

class VehiculeState extends State<Vehicule> {

 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
       actions: <Widget>[
         IconButton(
                icon: Icon(Icons.close, color: Colors.blue,),
                onPressed:(){
                 Navigator.pop(context);
                 
                } 
         ),
       ],
      ),
   
      backgroundColor: Colors.grey[300],
        body: Padding(
          padding: EdgeInsets.all(8),

           child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
           children:
             [
               GridCell(
                 title: "2 roues ",
                 description: "Moto,Scooter,..",
                 imageURL: "https://img.icons8.com/ultraviolet/80/000000/motorcycle.png",
                 
               ),GridCell(
               title: "Petit ",
               description: "Clio,208,Twingo..",
               imageURL: "",
             ),GridCell(
               title: "Moyen",
               description: "Megane,Scenic,C3..",
               imageURL: "",
             ),GridCell(
               title: "Grand ",
               description: "C4 Picasso,BMW,Tiguan..",
               imageURL: "",
             ),GridCell(
               title: "Haut",
               description: "Renauld Traffic,..",
               imageURL: "",
             ),GridCell(
               title: "Très Haut",
               description: "Mercedes sprinter..",
               imageURL: "",
             ),

             ]

           )
       )



    ),


    );


  }


}


class GridCell extends StatelessWidget
{
  final String title;
  final String description;
  final String imageURL;
 
  
   GridCell({Key key , this.title , this.description , this.imageURL }) : super( key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
      ),
      child: FlatButton(
        onPressed: (){
         Vehicule.title = title ;
         
          
        },
        child: Column(
          children: [
            Image.network(imageURL),
            Text(title),
            Text(description),
            
          ],
        ),
      ),
    );
  }

}