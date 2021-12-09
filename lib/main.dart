import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

void main() async {
  
  runApp(
    MultiProvider(
      providers: providers,
      builder: (context, child) => const Evento(),
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
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor:
                MediaQuery.of(context).size.width <= 800 ? 0.8 : 1.9,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
