import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/calendar_provider.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/fincalendar_provider.dart';
import 'package:mawqif/src/providers/searcch_provider/address.dart';
import 'package:mawqif/src/providers/searcch_provider/search_provider.dart';
import 'package:mawqif/src/providers/vehicule_provider/nomV_provider.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import './src/providers/parking_provider/parkings.dart';
import './src/providers/reservation_provider/reservations.dart';
import './src/providers/users/users.dart';
import './src/ui/home_screen.dart';
import './src/utils/loading.dart';
import 'src/providers/map/states.dart';
import 'src/ui/reservation/authentification/auth_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),
  //"/intro": (BuildContext context) => MyApp(),
};
void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(
          create: (context) => Parkings(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(create: (context) => FinCalendarProvider()),
        ChangeNotifierProvider(create: (context) => CalendarProvider()),
        //ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => VehiculeProvider()),
        ChangeNotifierProvider(create: (context) => Reservations()),
        // ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Users()),
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => CastFilter()),
        ChangeNotifierProxyProvider<SearchProvider, AddressProvider>(
          create: (context) => AddressProvider(),
          update: (context, catalog, cart) {
            cart.setadress = catalog.message;
            return cart;
          },
        ),
        ChangeNotifierProxyProvider<VehiculeProvider, NomVehiculeProvider>(
          create: (context) => NomVehiculeProvider(),
          update: (context, catalog, cart) {
            cart.setNomV = catalog.nomV;
            return cart;
          },
        )
      ],
      child: MaterialApp(
          home: Consumer<Auth>(
              builder: (ctx, auth, _) => MaterialApp(
                  home: auth.isAuth
                      ? MyApp()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? LoadingScreen()
                                  : AuthScreen(),
                        ))))));
}
