import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/ui/plus/profile.dart';
import 'package:provider/provider.dart';

class Plus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "                            PLUS",
            style: TextStyle(color: Colors.blueGrey[800]),
          ),
          backgroundColor: Colors.blueGrey[50],
        ),
        body: Column(children: <Widget>[
          Container(
            height: 20,
          ),
          Container(
            child: FlatButton(
              disabledColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Mon profil",
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    width: 180,
                  ),
                  Align(
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.blue,
                    ),
                    alignment: Alignment.topRight,
                  ),
                ],
              ),
              onPressed: () {
                if (!provider.isAuth) {
                  print("LOG IN ");
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }
              },
            ),
          ),
          Container(
            height: 20,
          ),
          Container(
              child: FlatButton(
            disabledColor: Colors.transparent,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 11,
                ),
                Text("Je suis propriétaire",
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  width: 100,
                ),
                Align(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                  ),
                  alignment: Alignment.topRight,
                )
              ],
            ),
            onPressed: () async {
              // Application apps = await DeviceApps.getApp('MAWQIF_LOC');
              List<Application> apps =
                  await DeviceApps.getInstalledApplications(
                      onlyAppsWithLaunchIntent: true, includeSystemApps: true);
              print(apps.toString());
              DeviceApps.openApp('MAWQIF_LOC');
            },
          ))
        ]));
  }
}
