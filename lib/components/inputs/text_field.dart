import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvTextField extends StatefulWidget {
  const EvTextField({
    required this.label,
    required this.iKey,
    this.msg = const {},
    Key? key,
    this.obscureText = false,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.type,
    this.action,
    this.control,
  }) : super(key: key);
  final String iKey;
  final String label;
  final Map<String, String> msg;
  final bool? obscureText;
  final IconData? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final InputType? type;
  final TextInputAction? action;
  final FormControl<String>? control;

  @override
  State<EvTextField> createState() => _EvTextFieldState();
}

class _EvTextFieldState extends State<EvTextField> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReactiveTextField<String>(
          formControlName: widget.iKey,
          validationMessages: (control) => {
            ValidationMessage.required:
                'The ${widget.label} field must not be empty'
          }..addAll(widget.msg),
          textInputAction: widget.action ?? TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: widget.prefixIcon,
                  ),
            contentPadding: EdgeInsets.all(Insets.m),
            border: _br(theme.grey),
            focusedErrorBorder: _br(theme.error),
            focusedBorder: _br(theme.primary),
            errorBorder: _br(theme.error),
            disabledBorder: _br(theme.grey),
            enabledBorder: _br(theme.primary),
            icon: widget.icon == null ? null : Icon(widget.icon),
            hintText: widget.hint,
            hintStyle: TextStyles.body1.textColor(theme.grey),
            labelText: widget.label,
            counterText: '',
            errorStyle: TextStyles.footnote.textHeight(.1),
          ),
          obscureText: widget.obscureText ?? false,
          style: TextStyles.body1.textColor(theme.txt),
          enableInteractiveSelection: true,
          cursorRadius: Corners.s5Radius,
          keyboardType: _setKeyboardType(),
          formControl: widget.control,
        ),
        VSpace(Insets.l),
      ],
    );
  }

  TextInputType _setKeyboardType() {
    TextInputType _type;
    switch (widget.type) {
      case InputType.email:
        _type = TextInputType.emailAddress;
        break;
      case InputType.money:
        _type = TextInputType.number;
        break;
      case InputType.tel:
        _type = TextInputType.phone;
        break;
      case InputType.num:
        _type = const TextInputType.numberWithOptions(decimal: true);
        break;
      case InputType.txt:
        _type = TextInputType.text;
        break;
      default:
        _type = TextInputType.text;
    }
    return _type;
  }
}

OutlineInputBorder _br(Color color) => OutlineInputBorder(
      borderRadius: Corners.s5Border,
      borderSide: BorderSide(color: color),
    );
