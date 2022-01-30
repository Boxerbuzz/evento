import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  List<String> selected = [];
  bool isOrganizer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace.lg,
              EvCategorySelector(
                label: R.S.likes,
                prefix: EvSvgIc(R.I.category.svgB),
                onChanged: (value) =>
                    setState(() => selected = value.map((e) => e).toList()),
                selected: selected,
                options: const <String>[
                  'Science',
                  'Education',
                  'Sports',
                  'Music',
                  'Concerts',
                  'Comedy',
                  'Movies',
                  'Tech',
                  'Restaurants',
                  'Birthdays',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
