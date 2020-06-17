import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/searcch_provider/address.dart';
import 'package:mawqif/src/providers/searcch_provider/search_provider.dart';
import 'package:provider/provider.dart';
class Search extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
 



}

class _SearchState extends State<Search> {

  TextEditingController t1 = new TextEditingController();
  void initState() {
    t1 = TextEditingController();
  }

  void dispose() {
    super.dispose();
    t1.dispose();
  }

    String _positionActuelle = "Ma position actuelle";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                '       Addresse de destination',
                style: TextStyle(
                    color: Colors.blueGrey, fontStyle: FontStyle.normal),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Container(
                  width: 15.0,
                  height: 2.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[50]))),
                  child: TextField(
                      controller: t1,
                      autofocus: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText:
                            '${Provider.of<AddressProvider>(context).adress}',
                        focusColor: Colors.grey,
                      ),
                      onSubmitted: (String value) async {
                        Provider.of<SearchProvider>(context).setMessage(value);
                      }),
                ),
                Container(height: 5.0, width: 5.0),
                Container(
                    child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.gps_fixed,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 15.0,
                      ),
                      Text(
                        _positionActuelle,
                        style: TextStyle(color: Colors.blueGrey[800]),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Future b = provider.displayCurrentLocation() ;
                    String a = b.toString();
                    Provider.of<SearchProvider>(context).setMessage(a);
                  },
                )),
                Container(height: 5.0, width: 5.0),
               
              ],
            )));
  }
}
