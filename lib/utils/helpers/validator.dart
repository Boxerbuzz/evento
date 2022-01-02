class InputValidator {
  const InputValidator();

  static bool validate(InputType type, String? value) {
    if (type.runtimeType == InputType) {
      switch (type) {
        case InputType.email:
          return _email(value);
        case InputType.tel:
          return _phone(value);
        case InputType.txt:
          return _text(value);
        case InputType.pwd:
          return _pwd(value);
        default:
          return true;
      }
    }
    return false;
  }

  static bool isEmail(String value) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  static bool _text(String? s) => s == null || s.trim().isEmpty;

  static bool _email(String? value) {
    if (value == null) return false;
    RegExp emailRegExp =
    RegExp(r"(^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$)");
    return emailRegExp.hasMatch(value);
  }

  static bool _phone(String? value) {
    if (value == null) return false;
    RegExp telRegExp = RegExp(r"(^[\+]?[234]\d{12}$)");
    //(^(1\s?)?(\(\d{3}\)|\d{3})[\s\-]?\d{3}[\s\-]?\d{4}$)
    return telRegExp.hasMatch(value);
  }

  static bool _pwd(String? password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
    password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLength;

    return hasDigits &
    hasUppercase &
    hasLowercase &
    hasSpecialCharacters &
    hasMinLength;
  }
}

enum InputType { txt, date, money, tel, pwd, num, email }
