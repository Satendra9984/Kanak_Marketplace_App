class GoldUser {
  String userName;
  String uniqueId;
  String customerMappedId;
  String mobileNumber;
  String dateOfBirth;
  String gender;
  String userEmail;
  String userAddress;
  String userStateId;
  String userCityId;
  String userPincode;
  String nomineeName;
  String nomineeRelation;
  String nomineeDateOfBirth;
  String kycStatus;
  String userState;
  String userCity;
  String createdAt;
  Map<String, dynamic> utmDetails;

  GoldUser({
    required this.userName,
    required this.uniqueId,
    required this.customerMappedId,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.userEmail,
    required this.userAddress,
    required this.userStateId,
    required this.userCityId,
    required this.userPincode,
    required this.nomineeName,
    required this.nomineeRelation,
    required this.nomineeDateOfBirth,
    required this.kycStatus,
    required this.userState,
    required this.userCity,
    required this.createdAt,
    required this.utmDetails,
  });

  factory GoldUser.fromJson(Map<String, dynamic> json) {
    return GoldUser(
      userName: json['userName'],
      uniqueId: json['uniqueId'],
      customerMappedId: json['customerMappedId'],
      mobileNumber: json['mobileNumber'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      userEmail: json['userEmail'],
      userAddress: json['userAddress'],
      userStateId: json['userStateId'],
      userCityId: json['userCityId'],
      userPincode: json['userPincode'],
      nomineeName: json['nomineeName'],
      nomineeRelation: json['nomineeRelation'],
      nomineeDateOfBirth: json['nomineeDateOfBirth'],
      kycStatus: json['kycStatus'],
      userState: json['userState'],
      userCity: json['userCity'],
      createdAt: json['createdAt'],
      utmDetails: json['utmDetails'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'uniqueId': uniqueId,
        'customerMappedId': customerMappedId,
        'mobileNumber': mobileNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'userEmail': userEmail,
        'userAddress': userAddress,
        'userStateId': userStateId,
        'userCityId': userCityId,
        'userPincode': userPincode,
        'nomineeName': nomineeName,
        'nomineeRelation': nomineeRelation,
        'nomineeDateOfBirth': nomineeDateOfBirth,
        'kycStatus': kycStatus,
        'userState': userState,
        'userCity': userCity,
        'createdAt': createdAt,
        'utmDetails': utmDetails,
      };
}
