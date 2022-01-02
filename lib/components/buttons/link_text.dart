import 'package:evento/exports.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EvLinkText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final TextAlign textAlign;

  const EvLinkText({
    Key? key,
    required this.text,
    this.textStyle,
    this.linkStyle,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  _LinkTextState createState() => _LinkTextState();
}

class _LinkTextState extends State<EvLinkText> {
  late List<TapGestureRecognizer> _gestureRecognizers;

  final RegExp _regex = RegExp(
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%.,_\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\,+.~#?&//=]*)");

  @override
  void initState() {
    super.initState();
    _gestureRecognizers = <TapGestureRecognizer>[];
  }

  @override
  void dispose() {
    for (var recognizer in _gestureRecognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  void _launch(String? url) async {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textStyle = widget.textStyle ?? TextStyles.body1;
    final linkStyle =
        widget.linkStyle ?? TextStyles.body1.textColor(themeData.primaryColor);

    final links = _regex.allMatches(widget.text);

    if (links.isEmpty) {
      return SelectableText(widget.text, style: textStyle);
    }

    final textParts = widget.text.split(_regex);
    final textSpans = <TextSpan>[];

    int i = 0;
    for (var part in textParts) {
      textSpans.add(TextSpan(text: part, style: textStyle));
      if (i < links.length) {
        final link = links.elementAt(i).group(0);
        final recognizer = TapGestureRecognizer()..onTap = () => _launch(link);
        _gestureRecognizers.add(recognizer);
        textSpans.add(
          TextSpan(text: link, style: linkStyle, recognizer: recognizer),
        );
        i++;
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
      textAlign: widget.textAlign,
    );
  }
}
