/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:provider/provider.dart';

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.times, color: Colors.white,),
            onPressed: () {}),
       // title: Text("Filter Result", style: TextStyle(color: Colors.white,),),
        /*actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.home, color: Colors.white,),
              onPressed: () {
                //
              }),
        ],*/
      ),
      body: Column(
        children: <Widget>[
          Align
            (
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer("Choose amenities"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Align
              (
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      filterChipWidget(chipName: 'Couvert'),
                      filterChipWidget(chipName: 'Souterrain'),
                      filterChipWidget(chipName: 'Vidéo surveillance'),
                      filterChipWidget(chipName: 'Eclairé'),
                      filterChipWidget(chipName: 'Pratique avec poussette ou bagage'),
                      //filterChipWidget(chipName: 'Wheelchair access'),

                    ],
                  )
              ),
            ),
          ),
          Divider(color: Colors.blueGrey, height: 10.0,),
         /* Align
            (
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer('Choose Neighborhoods'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Align
              (
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    filterChipWidget(chipName: 'Upper Manhattan'),
                    filterChipWidget(chipName: 'Manhattanville'),
                    filterChipWidget(chipName: 'Harlem'),
                    filterChipWidget(chipName: 'Washington Heights'),
                    filterChipWidget(chipName: 'Inwood'),
                    filterChipWidget(chipName: 'Morningside Heights'),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.blueGrey, height: 10.0,),*/
        ],
      ),
    );
  }

}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    List<Parking> _items = Provider.of<Parkings>(context).items ;
        var filterItems = buildItemsByFilter(_isSelected , _items);

    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Color(0xff6200ee),fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xffeadffd),);
  }

  List<String> buildItemsByFilter(bool isLonger3Cm , List<Parking> _items) {
    if (isLonger3Cm) {
      return _items.where((item) {
        return item.couvert== true;
      }).map((item) {
        return "$item cm";
      }).toList();
    } else {
      return _items.map((item) {
        return "$item cm";
      }).toList();
    }
  }
  

   
}

*/

//import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

/*lass MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}*/

/*class ChoiceChips extends StatefulWidget {
  ChoiceChips({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChoiceChips> {
  List<String> reportList = [
    "Not relevant",
    "Illegal",
    "Spam",
    "Offensive",
    "Uncivil"
  ];

  List<String> selectedReportList = List();

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Report Video"),
            content: MultiSelectChip(
              reportList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Report"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Report"),
              onPressed: () => _showReportDialog(),
            ),
            Text(selectedReportList.join(" , ")),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}*/




import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:provider/provider.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class CastFilter extends StatefulWidget with ChangeNotifier{
    static List<String> filters = <String>[];

    List<String> get filter {
    return [...filters];
  }


  @override
  State createState() => CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Couvert', 'AB'),
    const ActorFilterEntry('Souterrain', 'AH'),
    const ActorFilterEntry('Vidéo surveillance', 'EH'),
    const ActorFilterEntry('Eclairé', 'JM'),
  ];

  Iterable<Widget> get actorWidgets sync* {
    for (final ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: CastFilter.filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                if(!CastFilter.filters.contains(actor.name)){
               CastFilter.filters.add(actor.name);}
              // notifyListeners();
              } else {
                CastFilter.filters.removeWhere((String name) {
                  return name == actor.name;
                });
               // notifyListeners();
              }
            });
          },
        ),
      );
    }

  
  

}

  
  @override
  Widget build(BuildContext context) {
   final provider=  Provider.of<Parkings>(context);
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.blueGrey[800]),),
      body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: actorWidgets.toList(),
        ),
        FlatButton(child: Text("Ok"), onPressed: () {
          //provider.filterParks(widget.filters);
         // print("OKKKKKKK");
          Navigator.pop(context);
        },),
        Text('Look for: ${CastFilter.filters.join(', ')}'),
      ],
    ));
  }
}

 /* @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }*/
    