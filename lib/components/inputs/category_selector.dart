import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvCategorySelector extends StatefulWidget {
  const EvCategorySelector({
    required this.options,
    required this.label,
    this.selected,
    this.onChanged,
    this.prefix,
    this.hint,
    Key? key,
  }) : super(key: key);
  final List<String> options;
  final List<String>? selected;
  final String label;
  final ValueChanged<List<String>>? onChanged;
  final Widget? prefix;
  final String? hint;

  @override
  State<EvCategorySelector> createState() => _EvCategoryState();
}

class _EvCategoryState extends State<EvCategorySelector> {
  late List<String>? _selected;
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _options = widget.options;
    _selected = widget.selected ?? [];
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return FocusableActionDetector(
      autofocus: false,
      enabled: true,
      mouseCursor: MouseCursor.uncontrolled,
      focusNode: FocusNode(),
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: Corners.s5Border,
            border: Border.all(color: theme.primary),
          ),
          padding: EdgeInsets.symmetric(horizontal: Insets.m, vertical: 8),
          child: Row(
            children: [
              widget.prefix ?? Container(),
              Expanded(
                child: _selected!.isEmpty
                    ? Text(widget.hint ?? widget.label, style: TextStyles.body1).padding(left: 10)
                    : EvHScroll(
                        child: Row(
                          children: [
                            HSpace.md,
                            ..._selected!.map((item) => _Item(item, selected: true).padding(right: 5)),
                          ],
                        ),
                      ),
              ),
              EvSvgIc(R.I.chevronDown.svgT),
            ],
          ),
        ),
        onTap: () => onInteract(),
      ),
    );
  }

  onInteract() async {
    // await showMaterialModalBottomSheet(
    //   context: context,
    //   builder: (_) => _EvSelector(
    //     _options,
    //     title: 'Select Events Category',
    //     selected: _selected ?? [],
    //     onChanged: (List<String> value) {
    //       widget.onChanged!(value);
    //       _selected = value.map((e) => e).toList();
    //     },
    //   ),
    // );
  }
}

class _Item extends StatelessWidget {
  const _Item(
    this.item, {
    this.onPressed,
    this.selected = false,
    Key? key,
  }) : super(key: key);
  final String item;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (icon != null) ...{
        //   Container(),
        // },
        Text(
          item.toUpperCase(),
          style: TextStyles.footnote.letterSpace(1).textColor(selected ? Colors.white : theme.primary),
        ).center().padding(all: 5),
        // if (onClose != null) ...{
        //   EvIcBtn(
        //     const Icon(
        //       Icons.close,
        //       color: Colors.white,
        //       size: 15,
        //     ),
        //     padding: const EdgeInsets.all(0),
        //     color: Colors.grey[300],
        //     //onFocusChanged: onFocusChanged,
        //     onPressed: onClose,
        //     shrinkWrap: true,
        //   ),
        // },
      ],
    );
    return IgnorePointer(
      ignoring: false,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: Corners.s5Border,
          color: selected ? theme.primary : null,
          border: Border.all(color: theme.primary),
        ),
        child: content,
      ).clickable(onPressed).animate(600.milliseconds, Curves.easeOutExpo),
    );
  }
}

class _EvSelector extends StatefulWidget {
  const _EvSelector(
    this.options, {
    required this.title,
    this.onChanged,
    this.selected = const [],
    Key? key,
  }) : super(key: key);
  final List<String> options;
  final String title;
  //final String? subTitle;
  final ValueChanged<List<String>>? onChanged;
  final List<String> selected;

  @override
  State<_EvSelector> createState() => _EvSelectorState();
}

class _EvSelectorState extends State<_EvSelector> {
  late List<String> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Corners.s8Border,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.l),
        //controller: ModalScrollController.of(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace.md,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: TextStyles.h6),
                      // widget.subTitle != null
                      //     ? Text(widget.subTitle ?? '', style: TextStyles.h6)
                      //     : const SizedBox.shrink(),
                    ],
                  ),
                ),
                EvIcBtn(
                  EvSvgIc(R.I.chevronDown.svgT),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            VSpace.md,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...widget.options.map(
                  (e) => _Item(
                    e,
                    onPressed: () => onSelected(e),
                    selected: _selected.any((element) => element == e),
                  ),
                ),
              ],
            ),
            VSpace.lg,
          ],
        ),
      ),
    );
  }

  onSelected(String value) {
    if (!_selected.contains(value)) {
      setState(() => _selected.add(value));
    } else if (_selected.contains(value)) {
      setState(() => _selected.remove(value));
    }
    widget.onChanged!(_selected);
  }
}
