import 'package:flutter/material.dart';
import 'package:evento/exports.dart';

import 'views/social.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            SvgPicture.asset('assets/images/logo.svg', height: 50, width: 50),
            VSpace(Insets.m),
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
            Text(R.S.singInWelcome, style: TextStyles.h5.semiBold),
            ReactiveFormBuilder(
              form: _form,
              builder: (context, form, child) {
                return Column(
                  children: [
                    VSpace(Insets.l),
                    EvTextField(
                      label: R.S.email,
                      iKey: R.S.flEmail,
                      msg: InputValidationMessage.email,
                      prefixIcon: EvSvgIc(R.I.email.svgT),
                    ),
                    EvTextField(
                      label: R.S.password,
                      iKey: R.S.flPassword,
                      msg: InputValidationMessage.password,
                      prefixIcon: EvSvgIc(R.I.lock1.svgT),
                    ),
                    Row(
                      children: [
                        EvCheckbox(onChanged: (value) {}, size: 20),
                        HSpace.md,
                        Text(R.S.rememberMe, style: TextStyles.body1.semiBold),
                        Expanded(child: Container()),
                        Text(R.S.forgetPwd, style: TextStyles.body1.semiBold)
                            .rippleClick(() {})
                      ],
                    ),
                    VSpace.xl,
                    EvPriTextBtn(R.S.signIn, onPressed: () {}),
                    VSpace.lg,
                    Text('OR', style: TextStyles.h6),
                    VSpace.lg,
                    const SocialLogin(),
                    VSpace.lg,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(R.S.noAccount, style: TextStyles.body1),
                        HSpace.sm,
                        Text(
                          R.S.signUp,
                          style: TextStyles.body1.textColor(theme.primary),
                        )
                      ],
                    ).rippleClick(() => _navigateToSignUp(context)),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _navigateToSignUp(BuildContext ctx) =>
      Navigator.push(ctx, RouteHelper.fadeScale(() => const SignupScreen()));
}

FormGroup _form() {
  return fb.group(
    <String, Object>{
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': [
        '',
        Validators.required,
        Validators.pattern(RegExp(r'[A-Z]')),
        Validators.pattern(RegExp(r'[0-9]')),
        Validators.pattern(RegExp(r'[a-z]')),
        Validators.pattern(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      ],
      'rememberMe': false,
    },
  );
}
