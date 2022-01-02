import 'dart:collection';
import 'dart:math';

import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final ValueNotifier<List<EventModel>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  getAllEvents() {
    Random rand = Random.secure();
    Color? color;
    final _kEventSource = {
      for (var item in List.generate(
        20,
        (index) {
          color = Colors.primaries[rand.nextInt(Colors.primaries.length)]
              [rand.nextInt(9) * 100];
          return index;
        },
      ))
        DateTime.utc(_kFirstDay.year, _kFirstDay.month, item * 5):
            List.generate(
          item % 4 + 1,
          (index) => EventModel(color: color),
        )
    };

    return LinkedHashMap<DateTime, List<EventModel>>(
        equals: isSameDay, hashCode: getHashCode)
      ..addAll(_kEventSource);
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<EventModel> _getEventsForDay(DateTime day) => getAllEvents()[day] ?? [];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        EvContainer(
          color: theme.surface,
          child: TableCalendar<EventModel>(
            firstDay: _kFirstDay,
            lastDay: _kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              markerSize: 3,
              rangeHighlightScale: 1,
              markersMaxCount: 1,
              defaultTextStyle: TextStyles.body1,
              weekendTextStyle: TextStyles.body1.textColor(theme.primary),
              markerDecoration: BoxDecoration(color: theme.accent),
              markersAnchor: 2.5,
            ),
            onDaySelected: _onDaySelected,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            headerStyle: HeaderStyle(
              leftChevronIcon: EvSvgIc(R.I.arrowLeft.svgT),
              rightChevronIcon: EvSvgIc(R.I.arrowRight.svgT),
              titleCentered: true,
              titleTextStyle: TextStyles.h6,
            ),
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyles.body1.bold,
              weekendStyle: TextStyles.body1.textColor(theme.primary).bold,
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<EventModel>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return value.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EvSvgIc(
                          R.I.calendar.svgB,
                          size: 100,
                          color: ColorHelper.shiftHsl(theme.primary, .15),
                        ).center(),
                        VSpace.sm,
                        Text(
                          'No Events',
                          style: TextStyles.h6.bold.textColor(theme.txt),
                        ),
                        Text(
                          R.S.eventsMsg,
                          style: TextStyles.body1
                              .textColor(theme.txt)
                              .textHeight(1.5),
                          textAlign: TextAlign.center,
                        ).padding(horizontal: 50, top: Insets.sm),
                      ],
                    ).animate(600.milliseconds, Curves.easeOutExpo)
                  : ListView.builder(
                      itemCount: value.length,
                      padding: EdgeInsets.only(top: Insets.m),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _Item(
                        model: value[index],
                      ),
                    ).animate(600.milliseconds, Curves.easeOutExpo);
            },
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({this.model, Key? key}) : super(key: key);
  final EventModel? model;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EvContainer(
            height: 40,
            width: 40,
            borderRadius: Corners.s5Border,
            color: theme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sun',
                  style: TextStyles.body1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '26',
                  style: TextStyles.h5.semiBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          HSpace.md,
          EvContainer(
            height: 65,
            width: context.widthPct(.75),
            borderRadius: Corners.s5Border,
            color: ColorHelper.shiftHsl(model!.color!, .08),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.m),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/e1.png'),
                  ),
                  HSpace.md,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '9:00 AM - 12:00 PM',
                          style: TextStyles.body2.textColor(theme.surface),
                        ),
                        VSpace.sm,
                        Text(
                          "Women's Leadership",
                          style: TextStyles.body1.textColor(theme.surface).bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int getHashCode(DateTime key) =>
    key.day * 1000000 + key.month * 10000 + key.year;

final _kToday = DateTime.now();
final _kFirstDay = DateTime(_kToday.year, _kToday.month - 3, _kToday.day);
final _kLastDay = DateTime(2060, _kToday.month + 3, _kToday.day);
