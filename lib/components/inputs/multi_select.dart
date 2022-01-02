import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvMultiSelect extends StatefulWidget {
  const EvMultiSelect({
    this.onChanged,
    this.noMargin = false,
    this.selected,
    this.options = const [],
    Key? key,
    this.more,
  }) : super(key: key);
  final List<String> options;
  final String? selected;
  final ValueChanged<String>? onChanged;
  final bool noMargin;
  final Widget? more;

  @override
  _EvMultiSelectState createState() => _EvMultiSelectState();
}

class _EvMultiSelectState extends State<EvMultiSelect> {
  List<String> _options = const [];
  late String _selected;

  @override
  void initState() {
    super.initState();
    _options = widget.options;
    _selected = widget.selected ?? _options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: widget.noMargin ? 0 : Insets.l),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        runSpacing: Insets.m,
        spacing: Insets.m,
        children: [
          ..._options.map((option) {
            if (option == 'More') return widget.more ?? Container();
            return _BuildOption(
                option: option,
                isSelected: _selected == option,
                callback: () {
                  AppHelper.unFocus();
                  _select(option);
                });
          }),
        ],
      ),
    );
  }

  void _select(String value) {
    setState(() => _selected = value);
    widget.onChanged!(value);
  }
}

class _BuildOption extends StatelessWidget {
  const _BuildOption(
      {this.callback, this.isSelected = false, required this.option, Key? key})
      : super(key: key);
  final String option;
  final bool isSelected;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      color: isSelected ? theme.primary : Colors.transparent,
      width: context.widthPct(.43),
      borderRadius: Corners.s5Border,
      border: Border.all(
        color: isSelected ? theme.primary : theme.grey,
        width: 1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Text(
            option,
            style: TextStyles.body1
                .textColor(isSelected ? theme.background : theme.txt),
          ),
        ),
      ),
    ).clickable(callback);
  }
}
