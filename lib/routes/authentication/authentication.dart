import 'package:flutter/material.dart';
import 'package:evento/exports.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpace(context.heightPct(.1)),
            Text(
              R.S.appName,
              style: TextStyles.h4.textShadows([
                Shadow(
                  color: theme.grey,
                  blurRadius: .1,
                  offset: const Offset(3, 5),
                )
              ]),
            ),
            VSpace(Insets.l),
            Text(R.S.singInWelcome, style: TextStyles.h6.semiBold),
            VSpace(Insets.l),
            Consumer<AuthProvider>(builder: (context, store, child) {
              return Column(
                children: [
                  EvTabBar(
                    index: store.pageIndex,
                    sections: const ['Login', 'Register'],
                    onTabPressed: (value) => store.pageIndex = value,
                  ),
                  VSpace(Insets.m),
                  IndexedStack(
                    index: store.pageIndex,
                    children: const [
                      /*_Login(),
                      _Signup(),*/
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}






