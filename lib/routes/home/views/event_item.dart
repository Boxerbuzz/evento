import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EvContainer(
      width: context.widthPct(.4),
      borderRadius: Corners.s5Border,
      margin: EdgeInsets.only(right: Insets.l),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(),
          ),
          VSpace.md,
          Text('Lorem Ipsum Dolemor', style: TextStyles.h6),
        ],
      ).padding(all: Insets.m),
    );
  }
}
