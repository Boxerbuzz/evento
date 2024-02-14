import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
                  'Create Account',
                  style: TextStyles.h5,
                ),
                Text(
                  'Fill out all the details below to create your account and get started',
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
                          onPressed: () => Navigator.push(
                            context,
                            RouteHelper.fadeScale(() => const SetupScreen()),
                          ),
                          loading: store.isSignup,
                        ),
                        VSpace.lg,
                        EvLinkText(
                          text: 'Already have an account? Login',
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
