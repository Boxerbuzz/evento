import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvCalendar extends StatefulWidget {
  const EvCalendar({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    Key? key,
  }) : super(key: key);
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;

  @override
  State<EvCalendar> createState() => _EvCalendarState();
}

class _EvCalendarState extends State<EvCalendar> {
  int _selectedIndex = 1;

  late DateTime _initialDate;

  late Iterable<DateTime> _weeksDays;

  late List<DateTime> _currentMonthsDays;

  late int _selectedWeekDay;

  late DateTime _selectedDay;

  late int _selectedMonth;

  late int _selectedYear;

  List<int> _monthList = [];

  List<int> _yearList = [];

  bool _isExpanded = true;

  late Color _unSelectedTextColor;

  late PageController _pageCtrl;

  _handleWeekMonthYearNav() {}

  @override
  void initState() {
    super.initState();
    _initialDate = widget.initialDate;
    _selectedDay = _initialDate;
    _selectedWeekDay = _initialDate.day;

    _selectedMonth = _initialDate.month;
    _selectedYear = _initialDate.year;

    _currentMonthsDays = DateHelper.daysInMonth(_initialDate);

    _pageCtrl = PageController();

    _monthList.clear();

    for (int i = 1; i < 13; i++) {
      _monthList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    _unSelectedTextColor = theme.isDark ? Colors.white : Colors.grey.shade500;
    return Column(
      children: [
        VSpace.md,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EvIcBtn(EvSvgIc(R.I.arrowLeft.svgT)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EvSvgIc(R.I.calendar.svgT),
                HSpace.md,
                Text(
                  DateHelper.getMonthName(_selectedMonth),
                  style: TextStyles.body1,
                ),
              ],
            ).rippleClick(_handleWeekMonthYearNav),
            EvIcBtn(EvSvgIc(R.I.arrowRight.svgT)),
          ],
        ),
        /*AnimatedSize(
          curve: Curves.easeInOut,
          duration: 600.milliseconds,
          reverseDuration: 300.milliseconds,
          child: PageView(
            controller: _pageCtrl,
            physics: const ClampingScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: [],
          ),
        ),*/
        EvIcBtn(
          EvSvgIc(
            R.I.chevronDown.svgT,
          ),
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
        ),
      ],
    );
  }

  Widget _builder(List<Widget> children) {
    List<Widget> _children = children;
    return GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: _children,
    );
  }

  List<Widget> _week() {
    final List<Widget> widgets = [];
    void addWidget(String str) {
      widgets.add(Text(str, style: TextStyles.body1).center());
    }

    DateHelper.weekdays.forEach(addWidget);
    return widgets;
  }

  List<Widget> _months() {
    final List<Widget> dayWidgets = [];
    List<DateTime> list;
    if (_isExpanded) {
      list = _currentMonthsDays;
    } else {
      list = DateHelper.daysInWeek(_selectedDay);
    }
    dayWidgets.addAll(_week());

    void addButton(DateTime day) {
      dayWidgets.add(
        Center(
          child: _EvDateBtn(
            day.day.toString().padLeft(2, '0'),
            selected: day.day == _selectedDay.day &&
                !DateHelper.isExtraDay(day, _initialDate),
            enable: day.day <= _initialDate.day &&
                !DateHelper.isExtraDay(day, _initialDate),
            unSelectedTextColor: _unSelectedTextColor,
            semanticsLabel: DateHelper.formatDay(day),
            onTap: () {
              setState(() {
                _selectedDay = day;
              });
            },
          ),
        ),
      );
    }

    list.forEach(addButton);
    return dayWidgets;
  }

  Widget _years() {
    final List<Widget> years = [];
    void addButton(int year) {
      years.add(
        _EvYearBtn(
          '$year',
          selected: year == _selectedYear,
          unSelectedTextColor: _unSelectedTextColor,
          onTap: () => setState(() => _selectedYear = year),
        ).center(),
      );
    }

    _yearList.forEach(addButton);
    return GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 6,
      children: years,
    );
  }

  List<Widget> _days() {
    final List<Widget> dayWidgets = [];

    void addButton(DateTime day) {
      dayWidgets.add(
        Center(
          child: _EvDateBtn(
            day.day.toString().padLeft(2, '0'),
            selected: day.day == _selectedWeekDay,
            unSelectedTextColor: _unSelectedTextColor,
            semanticsLabel: DateHelper.formatDay(day),
            onTap: () => setState(() => _selectedWeekDay = day.day),
          ),
        ),
      );
    }

    _weeksDays.forEach(addButton);
    return dayWidgets;
  }
}

class _EvDateBtn extends StatelessWidget {
  const _EvDateBtn(this.text,
      {Key? key,
      this.fontSize = 14.0,
      this.selected = false,
      required this.unSelectedTextColor,
      this.enable = true,
      this.onTap,
      this.semanticsLabel})
      : super(key: key);

  final String text;
  final double fontSize;
  final bool selected;
  final Color unSelectedTextColor;
  final GestureTapCallback? onTap;
  final bool enable;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    Widget child = _buildText(theme);
    if (enable) {
      child = InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: fontSize > 14 ? double.infinity : 32.0,
            minWidth: 32.0,
            maxHeight: 32.0,
            minHeight: 32.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: fontSize > 14 ? 10.0 : 0.0),
          decoration: selected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: theme.isDark ? null : Shadows.m(theme.primary, .1),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF5758FA), theme.primary],
                  ),
                )
              : null,
          alignment: Alignment.center,
          child: child,
        ),
      );
    }

    return child;
  }

  Widget _buildText(AppTheme theme) {
    return Text(
      text,
      semanticsLabel: semanticsLabel,
      style: TextStyle(color: getTextColor(theme), fontSize: fontSize),
    );
  }

  Color getTextColor(AppTheme theme) {
    return enable ? (selected ? Colors.white : unSelectedTextColor) : theme.txt;
  }
}

class _EvYearBtn extends StatelessWidget {
  const _EvYearBtn(this.text,
      {Key? key,
      this.selected = false,
      required this.unSelectedTextColor,
      this.enable = true,
      this.onTap,
      this.semanticsLabel})
      : super(key: key);

  final String text;
  final bool selected;
  final Color unSelectedTextColor;
  final GestureTapCallback? onTap;
  final bool enable;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    Widget child = _buildText(theme);
    if (enable) {
      child = InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: selected
              ? BoxDecoration(
                  borderRadius: Corners.s3Border,
                  boxShadow: theme.isDark ? null : Shadows.m(theme.primary, .1),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF5758FA), theme.primary],
                  ),
                )
              : null,
          alignment: Alignment.center,
          child: child,
        ).animate(2000.milliseconds, Curves.easeIn),
      );
    }

    return child;
  }

  Widget _buildText(AppTheme theme) {
    return Text(
      text,
      semanticsLabel: semanticsLabel,
      style: TextStyles.body1.textColor(getTextColor(theme)),
    );
  }

  Color getTextColor(AppTheme theme) {
    return enable ? (selected ? Colors.white : unSelectedTextColor) : theme.txt;
  }
}
