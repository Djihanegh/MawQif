import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoSurveillance extends StatefulWidget {
  final DocumentSnapshot document;
  VideoSurveillance(this.document);
  @override
  _VideoSurveillanceState createState() => _VideoSurveillanceState();
}

class _VideoSurveillanceState extends State<VideoSurveillance> {
  @override
  Widget build(BuildContext context) {
    bool video = widget.document.data['videosurveillance'];

    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        video ? Icon(Icons.check_box) : Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Vidéo-surveillance"),
      ],
    );
  }
}
