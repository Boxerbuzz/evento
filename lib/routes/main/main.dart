import 'package:evento/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme.surface,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: theme.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const EVBottomNav(),
        body: Consumer<AppProvider>(
          builder: (context, store, child) {
            return IndexedStack(
              index: store.currentPage,
              children: [
                const HomeScreen(),
                const ExploreScreen(),
                Container(),
                const EventScreen(),
                const ProfileScreen(),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.primaryVariant,
          onPressed: null,
          // onPressed: () async => showMaterialModalBottomSheet(
          //   context: context,
          //   builder: (context) => const CreateEventScreen(),
          // ),
          child: EvSvgIc(
            R.I.addItem.svgB,
            color: theme.background,
            size: 24,
          ),
        ),
      ),
    );
  }
}
