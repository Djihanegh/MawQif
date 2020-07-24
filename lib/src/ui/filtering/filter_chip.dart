import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:provider/provider.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class CastFilter extends StatefulWidget with ChangeNotifier {
  static List<String> filters = <String>[];

  List<String> get filter {
    return [...filters];
  }

  @override
  State createState() => CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Couvert', 'CV'),
    const ActorFilterEntry('Souterrain', 'ST'),
    const ActorFilterEntry('Vidéo surveillance', 'VS'),
    const ActorFilterEntry('Eclairé', 'EC'),
  ];

  Iterable<Widget> get actorWidgets sync* {
    for (final ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue, child: Text(actor.initials)),
          label: Text(actor.name),
          selected: CastFilter.filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                if (!CastFilter.filters.contains(actor.name)) {
                  CastFilter.filters.add(actor.name);
                }
              } else {
                CastFilter.filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blueGrey[800]),
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Wrap(
              children: actorWidgets.toList(),
            ),
            SizedBox(
              height: 450,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), color: Colors.blue),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                color: Colors.blue,
                child: Text(
                  "Continuez",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ));
  }
}
