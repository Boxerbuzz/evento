import 'package:evento/exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Evento Android',
    options: const FirebaseOptions(
      appId: '1:70767198657:web:f0216f7e553b4d8ed7af40',
      apiKey: 'AIzaSyARVOYx4wXFWYqIUKV8b7reSO_SqzBWdiU',
      messagingSenderId: '70767198657',
      projectId: 'evento-global',
      databaseURL: 'https://evento-global-default-rtdb.firebaseio.com',
      storageBucket: 'evento-global.appspot.com',
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppProvider()),
        ChangeNotifierProvider(create: (c) => AppAuthProvider()),
        ChangeNotifierProvider(create: (c) => ExploreProvider()),
        ChangeNotifierProvider(create: (c) => EventProvider()),
        Provider<BuildContext>(create: (c) => c),
        Provider(create: (c) => AuthApi()),
      ],
      builder: (_, child) => const Evento(key: ValueKey('base')),
    ),
  );
}

class Evento extends StatefulWidget {
  const Evento({super.key});

  @override
  State<Evento> createState() => _EventoState();
}

class _EventoState extends State<Evento> {
  AuthApi api = AuthApi();
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  void initState() {
    initLocation();
    super.initState();
  }

  initLocation() async {
    location.enableBackgroundMode(enable: true);

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (kDebugMode) {
      print(_locationData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeType = context.select<AppProvider, ThemeType>((val) => val.theme);

    AppTheme theme = AppTheme.fromType(themeType);
    return Provider.value(
      value: theme,
      child: MaterialApp(
        title: 'Evento',
        theme: theme.themeData,
        navigatorKey: R.G.navKey,
        debugShowCheckedModeBanner: false,
        home:
            const IntroScreen() /*StreamBuilder<User?>(
          stream: api.auth.authStateChanges(),
          builder: (context, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Material(child: EvBusy());
            }
            if (!mounted) api.fbUser = s.data;
            return s.data == null ? const IntroScreen() : const MainScreen();
          },
        )*/
        ,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(context.widthPx <= 800 ? 0.8 : 1.9),
          ),
          child: child!,
        ),
        routes: R.G.myRoutes,
      ),
    );
  }
}
