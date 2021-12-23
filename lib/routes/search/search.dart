import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      appBar: EvAppBar(title: R.S.search),
      body: Column(
        children: [
          VSpace.lg,
          Row(
            children: [
              const Expanded(child: EvSearchField()),
              HSpace.md,
              EvIcBtn(
                EvSvgIc(R.I.candle.svgT, color: theme.surface),
                bgColor: theme.primary,
                padding: const EdgeInsets.all(12),
                onPressed: () => showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => const FilterScreen()),
              ),
            ],
          ).padding(horizontal: Insets.l),
          VSpace.lg,
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: MockData.getEvents(),
              builder: (context, AsyncSnapshot<List<dynamic>> snap) {
                if (snap.connectionState == ConnectionState.waiting &&
                    snap.data == null) return const EvBusy();
                List<EventModel> events =
                    snap.data!.map((e) => EventModel.fromJson(e)).toList();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...events.reversed
                          .take(5)
                          .map((event) => EventItem(data: event)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
