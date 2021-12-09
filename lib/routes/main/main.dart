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
    return Scaffold(
      bottomNavigationBar: const EVBottomNav(),
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgIcon(
          R.I.add.svgB,
          color: theme.primaryVariant,
          size: 24,
        ),
      ),
    );
  }
}
