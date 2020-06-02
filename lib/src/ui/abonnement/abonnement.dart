import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/ui/widget/qr_code.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';

class Abonnement extends StatefulWidget {
  String heureD;
  String heureF;

  // Abonnement(this.heureD,this.heureF);

  /* static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 200.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: Duration(seconds: 2),
          curve: Curves.elasticIn,
          child: Image.asset('assets/images/carr.jpg'),
        ),
      ),
    );
  }
}
*/

 /* @override
  Widget build(BuildContext context) {
    DateTime heureD = Provider.of<Calendar>(context).getHeureD();
    DateTime heureF = Provider.of<Calendarr>(context).getHeureF();
    //print("HEUUUUURE ===="+heureD);

    return new SafeArea(
      child: Center(
        child: RotateAnimationDemo(heureD, heureF),
      ),
    );
  }
}

class RotateAnimationDemo extends StatefulWidget {
  DateTime heureD;
  DateTime heureF;
  RotateAnimationDemo(heureD, heureF);
  @override
  State<StatefulWidget> createState() => RotateAnimationDemoState();
}

class RotateAnimationDemoState extends State<RotateAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation base;
  Animation inverted;
  Animation gap;
  DateTime tempDate;
  DateTime heureF;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    base = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    inverted = Tween<double>(begin: 0.0, end: -2.0).animate(base);

    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    /*tempDate = new DateFormat('hh:mm').parse("${widget.heureD}");
    heureF = new DateFormat("hh:mm").parse("${widget.heureF}");
    print("TEMPSSSSSSSSSSS");
    print(tempDate);*/

 print("HEURREEEEDEBUUT");
 print("${widget.heureD}");
    return Scaffold(
        body: 
        
        /*Column(children: <Widget>[
      GestureDetector(
        onTap: () => controller.forward(),
        child: RotationTransition(
          turns: base,
          child: DashedCircle(
            gapSize: gap.value,
            dashes: 20,
            color: Colors.deepOrange,
            child: RotationTransition(
              turns: inverted,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(radius: 120.0, backgroundImage: NetworkImage(
                    //'https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Bill_Gates_Buys_Skype_%285707954468%29.jpg/2560px-Bill_Gates_Buys_Skype_%285707954468%29.jpg'),
                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRjnc_v4Tmwl6PTC4YeUk6r8fdfuez9m-uGKh9xXlqacUMtwdNq&usqp=CAU')
                    'https://previews.123rf.com/images/ihorbiliavskyi/ihorbiliavskyi1812/ihorbiliavskyi181200020/114296062-car-from-above-top-view-cute-cartoon-car-with-shadows-modern-urban-civilian-vehicle-english-style-si.jpg')),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Text("${widget.heureD}"),
      Text("${widget.heureF}")
    ]));
  }
}*/
    );
    
  }
    }

  
*/





  get id => null;

  createState() {
    return ReservationState();
  }
}

class ReservationState extends State<Abonnement> {

  
 /* _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }  */
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
               /* actions: <Widget>[ FlatButton(
          child: Text("Se déconnecter" , style: TextStyle(color: Colors.blue),),
        onPressed: (){
                _save('0');
                Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new AuthScreen(),
                    )
                );
              }, ),
              
              ],*/
              
              ),
        body: FutureBuilder(
      future: Provider.of<Reservations>(context, listen: false)
          .fetchAndSetReservations(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            // ...
            // Do error handling stuff
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<Reservations>(
              builder: (ctx, orderData, child) => /*ListView.builder(
                itemCount: orderData.items.length,
                itemBuilder: (ctx, i) => */
               // ReservationItems(orderData.items[i]),
               QrCode(orderData.items[0].userInfo)
         //     ),
              //QrCode(orderData.items[i].userInfo)
            );
          }
        }
      },
    ));
  }
}
