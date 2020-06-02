import 'package:flutter/cupertino.dart';

class Item extends StatefulWidget{
  String text ;
  Item({@required this.text});
  @override
  State<StatefulWidget> createState() {
    return ItemState();
  }

}

class ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(widget.text),);
  }

}