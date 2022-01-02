import 'package:evento/exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppProvider()),
        ChangeNotifierProvider(create: (c) => AuthProvider()),
        ChangeNotifierProvider(create: (c) => ExploreProvider()),
        ChangeNotifierProvider(create: (c) => EventProvider()),
        Provider<BuildContext>(create: (c) => c),
        Provider(create: (c) => AuthApi()),
      ],
      builder: (_, child) => const Evento(key: ValueKey('base')),
    ),
  );
}

class Evento extends StatelessWidget {
  const Evento({Key? key}) : super(key: key);

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
        home: const AuthScreen(),
        builder: (context, child) => MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: context.widthPx <= 800 ? 0.8 : 1.9,
          ),
        ),
        routes: R.G.myRoutes,
      ),
    );
  }
}
