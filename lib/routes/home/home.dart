import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EventModel> events =
        MockData.events.map((event) => EventModel.fromJson(event)).toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          VSpace.xl,
          EvSectionHeader(
            title: R.S.upcoming,
            more: true,
            click: () {},
          ).padding(horizontal: Insets.l),
          EvShowcase(
            items: events.take(3).toList(),
            onChange: (value) {},
          ),
          VSpace.lg,
          EvSectionHeader(
            title: R.S.popular,
            more: true,
            click: () {},
          ).padding(horizontal: Insets.l),
          ...events.reversed.take(5).map((event) => EventItem(data: event)),
        ],
      ),
    );
  }
}
