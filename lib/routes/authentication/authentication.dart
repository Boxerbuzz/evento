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
                      _Login(),
                      _Signup(),
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

class _Login extends StatelessWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, store, child) {
      return ReactiveFormBuilder(
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
              VSpace.xl,
              EvPriTextBtn(
                R.S.signIn,
                onPressed: () => AuthCmd(context).login(form),
                loading: store.isLogin,
              ),
              VSpace.lg,
            ],
          );
        },
      );
    });
  }
}

class _Signup extends StatelessWidget {
  const _Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, store, child) {
        return ReactiveFormBuilder(
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
                  type: InputType.email,
                ),
                EvTextField(
                  label: R.S.password,
                  iKey: R.S.flPassword,
                  msg: InputValidationMessage.password,
                  prefixIcon: EvSvgIc(R.I.lock1.svgT),
                  type: InputType.pwd,
                  obscureText: true,
                ),
                VSpace.lg,
                EvPriTextBtn(
                  R.S.signUp,
                  onPressed: () => AuthCmd(context).signup(form),
                  loading: store.isSignup,
                ),
                VSpace.lg,
              ],
            );
          },
        );
      },
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
