import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

import 'views/social.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      appBar: EvAppBar(bgColor: theme.background),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(R.S.singUpWelcome, style: TextStyles.h5.semiBold),
            ReactiveFormBuilder(
              form: _form,
              builder: (context, form, child) {
                return Column(
                  children: [
                    VSpace(Insets.l),
                    EvTextField(
                      label: R.S.firstName,
                      iKey: R.S.flFirstName,
                      msg: InputValidationMessage.text,
                      prefixIcon: EvSvgIc(R.I.profile.svgT),
                    ),
                    EvTextField(
                      label: R.S.lastName,
                      iKey: R.S.flLastName,
                      msg: InputValidationMessage.text,
                      prefixIcon: EvSvgIc(R.I.user.svgT),
                    ),
                    EvTextField(
                      label: R.S.email,
                      iKey: R.S.flEmail,
                      msg: InputValidationMessage.email,
                      prefixIcon: EvSvgIc(R.I.email.svgT),
                    ),
                    EvTextField(
                      label: R.S.phoneNumber,
                      iKey: R.S.flPhoneNumber,
                      msg: InputValidationMessage.phone,
                      prefixIcon: EvSvgIc(R.I.phone.svgT),
                    ),
                    EvTextField(
                      label: R.S.password,
                      iKey: R.S.flPassword,
                      msg: InputValidationMessage.password,
                      prefixIcon: EvSvgIc(R.I.lock1.svgT),
                    ),
                    VSpace.lg,
                    EvPriTextBtn(
                      R.S.signUp,
                      onPressed: () => _goHome(context),
                    ),
                    VSpace.lg,
                    Text('OR', style: TextStyles.h6),
                    VSpace.lg,
                    const SocialLogin(
                      tag1: 'signup1',
                      tag2: 'signup2',
                    ),
                    VSpace.lg,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(R.S.haveAccount, style: TextStyles.body1),
                        HSpace.sm,
                        Text(
                          R.S.signIn,
                          style: TextStyles.body1.textColor(theme.primary),
                        )
                      ],
                    ).rippleClick(() {}),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _goHome(BuildContext ctx) => Navigator.pushAndRemoveUntil(
      ctx, RouteHelper.fadeScale(() => const MainScreen()), (route) => false);
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
      'firstName': FormControl<String>(validators: [Validators.required]),
      'lastName': FormControl<String>(validators: [Validators.required]),
      'phoneNumber': FormControl<String>(validators: [Validators.required])
    },
  );
}
