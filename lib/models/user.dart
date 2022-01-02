class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? fcm;
  final String? id;
  final String? phone;
  final String? country;
  final String? state;
  final String? address;
  final double? lat;
  final double? lng;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.fcm,
    this.id,
    this.phone,
    this.country,
    this.state,
    this.address,
    this.lat,
    this.lng,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone_number'],
      state: json['state'],
      country: json['country'],
      address: json['address'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      fcm: json['fcm'],
      lat: json['lat'],
      lng: json['lan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'fcm': fcm,
      'phone_number': phone,
      'state': state,
      'country': country,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  UserModel update(String? firstName, lastName, email, fcm, id, phone, country,
      state, address, double? lat, double? lng) {
    return UserModel(
      id: id ?? this.id,
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
      fcm: fcm ?? this.fcm,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      country: country ?? this.country,
      state: state ?? this.state,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, email: $email, fcm: $fcm, id: $id, phone: $phone, country: $country, state: $state, address: $address, lat: $lat, lng: $lng}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          fcm == other.fcm &&
          id == other.id &&
          phone == other.phone &&
          country == other.country &&
          state == other.state &&
          address == other.address &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      fcm.hashCode ^
      id.hashCode ^
      phone.hashCode ^
      country.hashCode ^
      state.hashCode ^
      address.hashCode ^
      lat.hashCode ^
      lng.hashCode;
}
