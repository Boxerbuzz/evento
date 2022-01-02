class RegisterModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? id;

  RegisterModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'id': id,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RegisterModel &&
            runtimeType == other.runtimeType &&
            firstName == other.firstName &&
            lastName == other.lastName &&
            email == other.email &&
            password == other.password &&
            id == other.id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^

        password.hashCode ^
        id.hashCode;
  }

  @override
  String toString() {
    return 'RegisterModel{firstName: $firstName, lastName: $lastName, email: $email, password: $password, id: $id}';
  }
}

class LoginModel {
  String? email;
  String? password;

  LoginModel({this.password, this.email});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      password: json['password'],
      email: json['email'],
    );
  }
}
