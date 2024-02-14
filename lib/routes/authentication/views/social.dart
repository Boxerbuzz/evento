import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({this.tag1, this.tag2, Key? key}) : super(key: key);
  final String? tag1;
  final String? tag2;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: theme.background,
          elevation: 2,
          heroTag: tag1,
          child: SvgPicture.asset('assets/images/fb.svg'),
        ),
        HSpace.lg,
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: theme.background,
          elevation: 2,
          heroTag: tag2,
          child: SvgPicture.asset('assets/images/google.svg'),
        ),
      ],
    );
  }
}
