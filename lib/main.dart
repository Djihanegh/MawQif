import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/calendar_provider.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/fincalendar_provider.dart';
import 'package:mawqif/src/providers/searcch_provider/address.dart';
import 'package:mawqif/src/providers/searcch_provider/search_provider.dart';
import 'package:mawqif/src/providers/vehicule_provider/nomV_provider.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:mawqif/src/services/auth_service/auth_service.dart';
import 'package:mawqif/src/services/auth_service/auth_service_adapter.dart';
import 'package:mawqif/src/services/auth_service/email_secure_store.dart';
import 'package:mawqif/src/services/auth_service/firebase_email_link_handler.dart';
import 'package:mawqif/src/ui/widget/sign_in/auth_widget.dart';
import 'package:mawqif/src/ui/widget/sign_in/auth_widget_builder.dart';
import 'package:mawqif/src/utils/email_link_error_presenter.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import './src/providers/parking_provider/parkings.dart';
import './src/providers/reservation_provider/reservations.dart';
import './src/providers/users/users.dart';
import 'src/providers/map/states.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),
  //"/intro": (BuildContext context) => MyApp(),
};

Future<void> main() async {
  // Fix for: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // [initialAuthServiceType] is made configurable for testing
  const MyApp({
    this.initialAuthServiceType = AuthServiceType.firebase,
  });
  final AuthServiceType initialAuthServiceType;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
          ),

          Provider<AuthService>(
            create: (_) => AuthServiceAdapter(
              initialAuthServiceType: initialAuthServiceType,
            ),
            dispose: (_, AuthService authService) => authService.dispose(),
          ),
          Provider<EmailSecureStore>(
            create: (_) => EmailSecureStore(
              flutterSecureStorage: FlutterSecureStorage(),
            ),
          ),
          ProxyProvider2<AuthService, EmailSecureStore,
              FirebaseEmailLinkHandler>(
            update:
                (_, AuthService authService, EmailSecureStore storage, __) =>
                    FirebaseEmailLinkHandler(
              auth: authService,
              emailStore: storage,
              firebaseDynamicLinks: FirebaseDynamicLinks.instance,
            )..init(),
            dispose: (_, linkHandler) => linkHandler.dispose(),
          ),
        ],
        child: AuthWidgetBuilder(
            builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.indigo),
            home: EmailLinkErrorPresenter.create(
              context,
              child: AuthWidget(userSnapshot: userSnapshot),
            ),
          );
        }));
  }
}

/*
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
                        )))))*/
