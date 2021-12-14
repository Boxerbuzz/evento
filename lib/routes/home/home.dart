import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          VSpace.xl,
          EvSectionHeader(
            title: R.S.upcoming,
            more: true,
            click: () {},
          ).padding(horizontal: Insets.l),
          SkewH(items: const [{}, {}, {}, {}, {}], onChange: (value) {}),
        ],
      ),
    );
  }
}
