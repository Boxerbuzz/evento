import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selected = 'Today';
  String paid = 'Paid';

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace.md,
              Row(
                children: [
                  Text(R.S.filter, style: TextStyles.h4.semiBold)
                      .padding(left: Insets.l),
                  Expanded(child: Container()),
                  EvIcBtn(
                    EvSvgIc(R.I.chevronDown.svgT),
                    onPressed: () => Navigator.pop(context),
                  ),
                  HSpace.lg,
                ],
              ),
              VSpace.lg,
              EvHScroll(
                child: Row(
                  children: [
                    HSpace.lg,
                    EvEventTypeBtn(
                      selected: false,
                      icon: R.I.music.svgB,
                      label: 'Music',
                    ),
                    EvEventTypeBtn(
                      selected: true,
                      icon: R.I.reserve.svgB,
                      label: 'Food',
                    ),
                    EvEventTypeBtn(
                      selected: false,
                      icon: R.I.paint.svgB,
                      label: 'Art',
                    ),
                    EvEventTypeBtn(
                      selected: true,
                      icon: R.I.bitcoin.svgB,
                      label: 'Crypto',
                    ),
                    EvEventTypeBtn(
                      selected: false,
                      icon: R.I.science.svgB,
                      label: 'Science',
                    ),
                    EvEventTypeBtn(
                      selected: true,
                      icon: R.I.code.svgB,
                      label: 'Coding',
                    ),
                    EvEventTypeBtn(
                      selected: true,
                      icon: R.I.game.svgB,
                      label: 'Games',
                    ),
                  ],
                ),
              ),
              VSpace.lg,
              Row(
                children: [
                  Text('Date & Time', style: TextStyles.h6)
                      .padding(horizontal: Insets.l, vertical: Insets.l),
                  Expanded(child: Container()),
                  Text(
                    DateHelper.fullDayFormat(DateTime.now()),
                    style: TextStyles.h6.semiBold.textColor(theme.primary),
                  ),
                  HSpace.lg,
                ],
              ),
              EvMultiSelect(
                options: const ['Today', 'Tomorrow', 'This Week', 'More'],
                onChanged: (value) => setState(() => selected = value),
                selected: selected,
                more: const _BuildMoreDate(),
              ),
              VSpace.md,
              Text('Location', style: TextStyles.h6)
                  .padding(horizontal: Insets.l, vertical: Insets.l),
              EvContainer(
                height: 50,
                width: double.infinity,
                border: Border.all(color: theme.grey, width: 1),
                borderRadius: Corners.s5Border,
                color: Colors.transparent,
                child: Row(
                  children: [
                    HSpace.md,
                    EvIcBtn(
                      EvSvgIc(R.I.location.svgB, color: theme.surface),
                      bgColor: ColorHelper.shiftHsl(theme.primary, .1),
                    ),
                    HSpace.lg,
                    Expanded(
                      child: Text(
                        'New York, USA ',
                        style: TextStyles.body1,
                      ),
                    ),
                    EvSvgIc(R.I.chevronDown.svgT),
                    HSpace.md,
                  ],
                ),
              ).padding(horizontal: Insets.l),
              VSpace.md,
              Text("Ticket's", style: TextStyles.h6)
                  .padding(horizontal: Insets.l, vertical: Insets.l),
              EvMultiSelect(
                options: const ['Paid', 'Free'],
                onChanged: (value) => setState(() => paid = value),
                selected: paid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildMoreDate extends StatelessWidget {
  const _BuildMoreDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      color: Colors.transparent,
      width: context.widthPct(.43),
      borderRadius: Corners.s5Border,
      border: Border.all(
        color: theme.grey,
        width: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EvSvgIc(R.I.calendar.svgB),
              HSpace.sm,
              Text(
                "Custom Date",
                style: TextStyles.body1.textColor(theme.txt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
