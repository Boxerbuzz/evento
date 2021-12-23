import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvSearchField extends StatefulWidget {
  final void Function(String)? onChanged;
  const EvSearchField({Key? key, this.onChanged}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<EvSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      style: TextStyles.body1,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: ColorHelper.shiftHsl(theme.surface, .2),
        hintText: "Search...",
        hintStyle: TextStyles.body1.copyWith(color: theme.txt),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: EvIcBtn(
            EvSvgIc(
              R.I.search.svgT,
              color: theme.txt,
              size: 20,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: Insets.l,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Corners.s5Border,
          borderSide: const BorderSide(color: Colors.white, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: Corners.s5Border,
          borderSide: const BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
}