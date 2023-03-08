/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _fname;
  final String? _lname;
  final String? _email;
  final String? _phone;
  final Wallet? _wallet;
  final int? _pincode;
  final String? _goldProviderDetails;
  final List<BankAccount>? _bankAccounts;
  final List<Address>? _address;
  final String? _kycDetails;
  final TemporalDate? _dob;
  final String? _state;
  final String? _city;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _userWalletId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get fname {
    return _fname;
  }
  
  String? get lname {
    return _lname;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phone {
    return _phone;
  }
  
  Wallet? get wallet {
    return _wallet;
  }
  
  int? get pincode {
    return _pincode;
  }
  
  String? get goldProviderDetails {
    return _goldProviderDetails;
  }
  
  List<BankAccount>? get bankAccounts {
    return _bankAccounts;
  }
  
  List<Address>? get address {
    return _address;
  }
  
  String? get kycDetails {
    return _kycDetails;
  }
  
  TemporalDate? get dob {
    return _dob;
  }
  
  String? get state {
    return _state;
  }
  
  String? get city {
    return _city;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get userWalletId {
    return _userWalletId;
  }
  
  const User._internal({required this.id, fname, lname, email, phone, wallet, pincode, goldProviderDetails, bankAccounts, address, kycDetails, dob, state, city, createdAt, updatedAt, userWalletId}): _fname = fname, _lname = lname, _email = email, _phone = phone, _wallet = wallet, _pincode = pincode, _goldProviderDetails = goldProviderDetails, _bankAccounts = bankAccounts, _address = address, _kycDetails = kycDetails, _dob = dob, _state = state, _city = city, _createdAt = createdAt, _updatedAt = updatedAt, _userWalletId = userWalletId;
  
  factory User({String? id, String? fname, String? lname, String? email, String? phone, Wallet? wallet, int? pincode, String? goldProviderDetails, List<BankAccount>? bankAccounts, List<Address>? address, String? kycDetails, TemporalDate? dob, String? state, String? city, String? userWalletId}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      fname: fname,
      lname: lname,
      email: email,
      phone: phone,
      wallet: wallet,
      pincode: pincode,
      goldProviderDetails: goldProviderDetails,
      bankAccounts: bankAccounts != null ? List<BankAccount>.unmodifiable(bankAccounts) : bankAccounts,
      address: address != null ? List<Address>.unmodifiable(address) : address,
      kycDetails: kycDetails,
      dob: dob,
      state: state,
      city: city,
      userWalletId: userWalletId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _fname == other._fname &&
      _lname == other._lname &&
      _email == other._email &&
      _phone == other._phone &&
      _wallet == other._wallet &&
      _pincode == other._pincode &&
      _goldProviderDetails == other._goldProviderDetails &&
      DeepCollectionEquality().equals(_bankAccounts, other._bankAccounts) &&
      DeepCollectionEquality().equals(_address, other._address) &&
      _kycDetails == other._kycDetails &&
      _dob == other._dob &&
      _state == other._state &&
      _city == other._city &&
      _userWalletId == other._userWalletId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("fname=" + "$_fname" + ", ");
    buffer.write("lname=" + "$_lname" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("pincode=" + (_pincode != null ? _pincode!.toString() : "null") + ", ");
    buffer.write("goldProviderDetails=" + "$_goldProviderDetails" + ", ");
    buffer.write("kycDetails=" + "$_kycDetails" + ", ");
    buffer.write("dob=" + (_dob != null ? _dob!.format() : "null") + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userWalletId=" + "$_userWalletId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? fname, String? lname, String? email, String? phone, Wallet? wallet, int? pincode, String? goldProviderDetails, List<BankAccount>? bankAccounts, List<Address>? address, String? kycDetails, TemporalDate? dob, String? state, String? city, String? userWalletId}) {
    return User._internal(
      id: id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      wallet: wallet ?? this.wallet,
      pincode: pincode ?? this.pincode,
      goldProviderDetails: goldProviderDetails ?? this.goldProviderDetails,
      bankAccounts: bankAccounts ?? this.bankAccounts,
      address: address ?? this.address,
      kycDetails: kycDetails ?? this.kycDetails,
      dob: dob ?? this.dob,
      state: state ?? this.state,
      city: city ?? this.city,
      userWalletId: userWalletId ?? this.userWalletId);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _fname = json['fname'],
      _lname = json['lname'],
      _email = json['email'],
      _phone = json['phone'],
      _wallet = json['wallet']?['serializedData'] != null
        ? Wallet.fromJson(new Map<String, dynamic>.from(json['wallet']['serializedData']))
        : null,
      _pincode = (json['pincode'] as num?)?.toInt(),
      _goldProviderDetails = json['goldProviderDetails'],
      _bankAccounts = json['bankAccounts'] is List
        ? (json['bankAccounts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => BankAccount.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _address = json['address'] is List
        ? (json['address'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Address.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _kycDetails = json['kycDetails'],
      _dob = json['dob'] != null ? TemporalDate.fromString(json['dob']) : null,
      _state = json['state'],
      _city = json['city'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _userWalletId = json['userWalletId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'fname': _fname, 'lname': _lname, 'email': _email, 'phone': _phone, 'wallet': _wallet?.toJson(), 'pincode': _pincode, 'goldProviderDetails': _goldProviderDetails, 'bankAccounts': _bankAccounts?.map((BankAccount? e) => e?.toJson()).toList(), 'address': _address?.map((Address? e) => e?.toJson()).toList(), 'kycDetails': _kycDetails, 'dob': _dob?.format(), 'state': _state, 'city': _city, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userWalletId': _userWalletId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'fname': _fname, 'lname': _lname, 'email': _email, 'phone': _phone, 'wallet': _wallet, 'pincode': _pincode, 'goldProviderDetails': _goldProviderDetails, 'bankAccounts': _bankAccounts, 'address': _address, 'kycDetails': _kycDetails, 'dob': _dob, 'state': _state, 'city': _city, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'userWalletId': _userWalletId
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField FNAME = QueryField(fieldName: "fname");
  static final QueryField LNAME = QueryField(fieldName: "lname");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField WALLET = QueryField(
    fieldName: "wallet",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Wallet'));
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField GOLDPROVIDERDETAILS = QueryField(fieldName: "goldProviderDetails");
  static final QueryField BANKACCOUNTS = QueryField(
    fieldName: "bankAccounts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'BankAccount'));
  static final QueryField ADDRESS = QueryField(
    fieldName: "address",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Address'));
  static final QueryField KYCDETAILS = QueryField(fieldName: "kycDetails");
  static final QueryField DOB = QueryField(fieldName: "dob");
  static final QueryField STATE = QueryField(fieldName: "state");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField USERWALLETID = QueryField(fieldName: "userWalletId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.WALLET,
      isRequired: false,
      ofModelName: 'Wallet',
      associatedKey: Wallet.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PINCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.GOLDPROVIDERDETAILS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.BANKACCOUNTS,
      isRequired: false,
      ofModelName: 'BankAccount',
      associatedKey: BankAccount.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.ADDRESS,
      isRequired: false,
      ofModelName: 'Address',
      associatedKey: Address.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.KYCDETAILS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.DOB,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.STATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERWALLETID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
@immutable
class UserModelIdentifier implements ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}