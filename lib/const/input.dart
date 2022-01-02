import 'package:evento/exports.dart';

class InputValidationMessage {
  static Map<String, String> get email => {
        ValidationMessage.required: 'The email must not be empty',
        ValidationMessage.email: 'The email value must be a valid email',
      };

  static Map<String, String> get password => {
        ValidationMessage.required: 'The password must not be empty',
        ValidationMessage.minLength:
            'The password must be at least 9 characters',
        'pattern':
            'The password must match combination of alphanumeric characters and any special symbol'
      };

  static Map<String, String> get phone => {
        ValidationMessage.required: 'The phone number must not be empty',
        ValidationMessage.number: 'Only allows number characters',
      };

  static Map<String, String> get text => {};

  static Map<String, String> get number => {};
}
