import 'package:evento/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EvAppBar(
      {this.title, this.leading = true, this.trailing, this.bgColor, Key? key})
      : super(key: key);
  final String? title;
  final List<Widget>? trailing;
  final bool leading;
  final Color? bgColor;

  final double appBarSize = 50.0;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return AppBar(
      leading: leading
          ? EvIcBtn(
              EvSvgIc(R.I.arrowLeft.svgT),
              onPressed: () => Navigator.maybePop(context),
            )
          : const SizedBox.shrink(),
      title: StringHelper.isEmpty(title)
          ? null
          : Text(title ?? '', style: TextStyles.h5.semiBold),
      //centerTitle: true,
      actions: trailing ?? [],
      backgroundColor: bgColor ?? theme.surface,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: theme.surface,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);
}
