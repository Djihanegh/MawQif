import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/ui/widget/partners/partner_card_item.dart';
import 'package:provider/provider.dart';

class PartnerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PartnerScreenState();
  }
}

class PartnerScreenState extends State<PartnerScreen> {
  initState() {
    //Parkings parkNotifier = Provider.of<Parkings>(context, listen: false);
    //parkNotifier.getParks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Parkings parkNotifier = Provider.of<Parkings>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Container(height: 500, child: parksList(context)),
              ],
            )));
  }

  Widget parksList(BuildContext context) {
    Parkings parkNotifier = Provider.of<Parkings>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('loueur')
            /*.document('JAY4Idk3b4gs8kqhGEHt6KS27hg1')
            .collection('parking')*/
            .snapshots(),
        builder: (context, snapshot) {
          // Parking park = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              if (parkNotifier.items == null) {
                print("VIDE");
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (ctx, i) =>
                    PartnerCard(document: snapshot.data.documents[i], i: i),
              );
            }
          }
        });
  }
}
