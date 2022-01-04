import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

enum EvDS { info, error, success, warning }

class EvDialog extends StatelessWidget {
  final String title, msg, actionText, cancelText;
  final EvDS? state;
  final Function? cFunc;
  final String? icon;

  const EvDialog({
    Key? key,
    required this.title,
    required this.actionText,
    required this.msg,
    this.cFunc,
    this.cancelText = 'Cancel',
    this.state = EvDS.info,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    Color? _color;
    String _icon = R.I.closeSquare.svgB;
    switch (state) {
      case EvDS.error:
        _color = theme.error;
        break;
      case EvDS.success:
        _icon = R.I.tickCircle.svgB;
        _color = theme.primary;
        break;
      case EvDS.warning:
        _icon = R.I.warning.svgB;
        _color = theme.secondaryVariant;
        break;
      default:
        _icon = R.I.infoCircle.svgB;
        _color = theme.secondaryVariant;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: Corners.s0Border),
      contentPadding: EdgeInsets.zero,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Insets.m),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: Corners.s0Border,
            ),
            child: EvSvgIc(_icon, color: Colors.white),
          ),
          VSpace.md,
          Padding(
            padding: EdgeInsets.all(Insets.m),
            child: Column(
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: TextStyles.h6.textColor(_color),
                    textAlign: TextAlign.center,
                  ),
                if (msg.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(Insets.sm),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: TextStyles.body1.textColor(Colors.black45),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            children: [
              Divider(height: 1, color: theme.grey),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state != EvDS.info) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cancelText,
                          style: TextStyles.body1.textColor(theme.greyStrong),
                          textAlign: TextAlign.center,
                        ),
                      )
                          .center()
                          .clickable(() => Navigator.maybePop(context, false))
                          .expanded(),
                      SizedBox(
                        child: VerticalDivider(width: 1, color: theme.grey),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        actionText,
                        style: TextStyles.body1.textColor(
                            state == EvDS.error ? _color : theme.primary),
                        textAlign: TextAlign.center,
                      ),
                    )
                        .center()
                        .rClick(() => {if (cFunc != null) cFunc!()})
                        .expanded()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
