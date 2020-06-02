import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarr extends StatelessWidget with ChangeNotifier {
  static String _fin = "fin";
  static DateTime date1 , heureF ;
  static TimeOfDay hour = new TimeOfDay.now();
  static var now = DateTime.now();
  static var fmt = DateFormat("HH:mm").format(now);

    DateTime getHeureF()=> heureF ; 

  //static var hr = DateTime.now();
  //static var hh = DateFormat.H(DateTime.now()) ;

  String getFmt() => fmt;
  String get fin {
    return _fin;
  }

  void add(DateTime a, DateTime b) {
    _fin = b.toString();
    notifyListeners();
  }

  String getDate() {
    return _fin;
  }

  void setDate(DateTime value) {
    date1 = value;
    _fin = '${date1.year}-${date1.month}-${date1.day}';
    notifyListeners();
  }

  void setFmt(String value) {
    fmt = value;
    notifyListeners();
  }

  CalendarController _controller = new CalendarController();

  void initState() {
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATE ET HEURE DE FIN',
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.blueGrey[800],
                  selectedColor: Colors.blueGrey[800],
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                print(date.toIso8601String());
                setDate(date);
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            Container(
              width: 20.0,
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 80.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                    child: Text("Réserver pour maintenant",
                        style: TextStyle(color: Colors.blue)),
                    onPressed: () {
//Calendarr.date1 =  new DateFormat.yMMMd().format(new DateTime.now()) as DateTime ;
                    }),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 115.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue),
                  color: Colors.white),
              child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          '${Provider.of<Calendarr>(context).getFmt()} ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (time) {
                            print('confirm $time');
                            heureF = time ;
                            //var hour = '${time.hour} : ${time.minute}';
                            var fmt2 = DateFormat("HH:mm").format(time);
                            // var finalHour = DateFormat.H(hour).toString();
                            //Calendar.hh= DateFormat.Hm(time).toString();
                            //setFmt(fmt2);
                            Provider.of<Calendarr>(context).setFmt(fmt2);

                            //setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.fr);
                          // setState(() {});
                        },
                      ),
                      Icon(
                        Icons.access_time,
                        color: Colors.blue,
                      ),
                    ],
                  )),
            ),
            //Container(height: 100, width: 100,),
            Container(
              height: 92,
              width: 0,
            ),
            Container(
              // width: 600.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), color: Colors.blue),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
              //color: Colors.blue,
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                color: Colors.blue,
                child: Text(
                  'Confirmer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onPressed: () {
                  // Calendar.date1 =  new DateFormat.yMMMd().format(new DateTime.now()) as DateTime ;
                  // Provider.of<Recherche2>(context).add( Calendar.date1, Calendar.fmt2 );
//Provider.of<Recherche2>(context ).onToggle();
                  //Recherche2.debut_ = Calendar.date1.toString() ;
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
