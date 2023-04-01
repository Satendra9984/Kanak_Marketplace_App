class UserAddressResponse {
  final String userAddressId;
  final String userAccountId;
  final String name;
  final String email;
  final String address;
  final String stateId;
  final String cityId;
  final int pincode;
  final String status;
  final String mobileNumber;

  UserAddressResponse({
    required this.userAddressId,
    required this.userAccountId,
    required this.name,
    required this.email,
    required this.address,
    required this.stateId,
    required this.cityId,
    required this.pincode,
    required this.status,
    required this.mobileNumber
  });

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) {
    return UserAddressResponse(
      mobileNumber: json['mobileNumber'],
      userAddressId: json['userAddressId'],
      userAccountId: json['userAccountId'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      stateId: json['stateId'],
      cityId: json['cityId'],
      pincode: int.parse(json['pincode']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userAddressId': userAddressId,
      'userAccountId': userAccountId,
      'name': name,
      'email': email,
      'address': address,
      'stateId': stateId,
      'cityId': cityId,
      'pincode': pincode,
      'status': status,
      'mobileNumber': mobileNumber
    };
  }
}