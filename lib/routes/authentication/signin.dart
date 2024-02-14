import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.l),
        child: Consumer<AppAuthProvider>(
          builder: (context, store, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(50),
                EvSvgIc(R.I.arrowLeft.svgT),
                VSpace(context.heightPct(.02)),
                Text(
                  'Welcome back',
                  style: TextStyles.h5,
                ),
                Text(
                  'Input your email and password to get started',
                  style: TextStyles.t1.textColor(theme.greyStrong),
                ),
                VSpace(context.heightPct(.07)),
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
                          type: InputType.email,
                        ),
                        EvTextField(
                          label: R.S.password,
                          iKey: R.S.flPassword,
                          msg: InputValidationMessage.password,
                          prefixIcon: EvSvgIc(R.I.lock1.svgT),
                        ),
                        Row(
                          children: [
                            EvCheckbox(
                              onChanged: (value) => store.rememberMe = value,
                              size: 20,
                              value: store.rememberMe,
                            ),
                            HSpace.md,
                            Text(R.S.rememberMe, style: TextStyles.body1.semiBold),
                            Expanded(child: Container()),
                            Text(
                              R.S.forgetPwd,
                              style: TextStyles.body1.semiBold,
                            ).rClick(() {})
                          ],
                        ),
                        VSpace.lg,
                        VSpace.xl,
                        EvPriTextBtn(
                          R.S.signIn,
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context, RouteHelper.fadeScale(() => const MainScreen()), (route) => false),
                          loading: store.isLogin,
                        ),
                        VSpace.lg,
                        EvLinkText(
                          text: "Don't have an account? Signup",
                          textStyle: TextStyles.h7,
                        ).rClick(() => Navigator.push(context, RouteHelper.fadeScale(() => const LoginScreen()))),
                        VSpace.lg,
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

FormGroup _form() {
  return fb.group(<String, Object>{
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(RegExp(r'[A-Z]')),
      Validators.pattern(RegExp(r'[0-9]')),
      Validators.pattern(RegExp(r'[a-z]')),
      Validators.pattern(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    ]),
    'firstName': FormControl<String>(
      validators: [Validators.required],
    ),
    'lastName': FormControl<String>(
      validators: [Validators.required],
    ),
  });
}
