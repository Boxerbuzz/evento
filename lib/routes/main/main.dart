import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
          onPressed: () => showMaterialModalBottomSheet(
              context: context, builder: (context) => const CreateEventScreen()),
          child: EvSvgIc(
            R.I.add.svgT,
            color: theme.background,
            size: 24,
          ),
          backgroundColor: theme.primaryVariant,
        ),
      ),
    );
  }
}
