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
  final int? _sgId;
  final String? _phone;
  final String? _email;
  final String? _pincode;
  final String? _pfp;
  final TemporalDateTime? _joiningDate;
  final double? _balance;
  final String? _kyc;
  final bool? _sgVerified;
  final List<Transaction>? _transactions;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  int? get sgId {
    return _sgId;
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get email {
    return _email;
  }
  
  String? get pincode {
    return _pincode;
  }
  
  String? get pfp {
    return _pfp;
  }
  
  TemporalDateTime? get joiningDate {
    return _joiningDate;
  }
  
  double? get balance {
    return _balance;
  }
  
  String? get kyc {
    return _kyc;
  }
  
  bool? get sgVerified {
    return _sgVerified;
  }
  
  List<Transaction>? get transactions {
    return _transactions;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, sgId, phone, email, pincode, pfp, joiningDate, balance, kyc, sgVerified, transactions, createdAt, updatedAt}): _sgId = sgId, _phone = phone, _email = email, _pincode = pincode, _pfp = pfp, _joiningDate = joiningDate, _balance = balance, _kyc = kyc, _sgVerified = sgVerified, _transactions = transactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, int? sgId, String? phone, String? email, String? pincode, String? pfp, TemporalDateTime? joiningDate, double? balance, String? kyc, bool? sgVerified, List<Transaction>? transactions}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      sgId: sgId,
      phone: phone,
      email: email,
      pincode: pincode,
      pfp: pfp,
      joiningDate: joiningDate,
      balance: balance,
      kyc: kyc,
      sgVerified: sgVerified,
      transactions: transactions != null ? List<Transaction>.unmodifiable(transactions) : transactions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _sgId == other._sgId &&
      _phone == other._phone &&
      _email == other._email &&
      _pincode == other._pincode &&
      _pfp == other._pfp &&
      _joiningDate == other._joiningDate &&
      _balance == other._balance &&
      _kyc == other._kyc &&
      _sgVerified == other._sgVerified &&
      DeepCollectionEquality().equals(_transactions, other._transactions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("sgId=" + (_sgId != null ? _sgId!.toString() : "null") + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("pincode=" + "$_pincode" + ", ");
    buffer.write("pfp=" + "$_pfp" + ", ");
    buffer.write("joiningDate=" + (_joiningDate != null ? _joiningDate!.format() : "null") + ", ");
    buffer.write("balance=" + (_balance != null ? _balance!.toString() : "null") + ", ");
    buffer.write("kyc=" + "$_kyc" + ", ");
    buffer.write("sgVerified=" + (_sgVerified != null ? _sgVerified!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({int? sgId, String? phone, String? email, String? pincode, String? pfp, TemporalDateTime? joiningDate, double? balance, String? kyc, bool? sgVerified, List<Transaction>? transactions}) {
    return User._internal(
      id: id,
      sgId: sgId ?? this.sgId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      pincode: pincode ?? this.pincode,
      pfp: pfp ?? this.pfp,
      joiningDate: joiningDate ?? this.joiningDate,
      balance: balance ?? this.balance,
      kyc: kyc ?? this.kyc,
      sgVerified: sgVerified ?? this.sgVerified,
      transactions: transactions ?? this.transactions);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _sgId = (json['sgId'] as num?)?.toInt(),
      _phone = json['phone'],
      _email = json['email'],
      _pincode = json['pincode'],
      _pfp = json['pfp'],
      _joiningDate = json['joiningDate'] != null ? TemporalDateTime.fromString(json['joiningDate']) : null,
      _balance = (json['balance'] as num?)?.toDouble(),
      _kyc = json['kyc'],
      _sgVerified = json['sgVerified'],
      _transactions = json['transactions'] is List
        ? (json['transactions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Transaction.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'sgId': _sgId, 'phone': _phone, 'email': _email, 'pincode': _pincode, 'pfp': _pfp, 'joiningDate': _joiningDate?.format(), 'balance': _balance, 'kyc': _kyc, 'sgVerified': _sgVerified, 'transactions': _transactions?.map((Transaction? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'sgId': _sgId, 'phone': _phone, 'email': _email, 'pincode': _pincode, 'pfp': _pfp, 'joiningDate': _joiningDate, 'balance': _balance, 'kyc': _kyc, 'sgVerified': _sgVerified, 'transactions': _transactions, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SGID = QueryField(fieldName: "sgId");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField PFP = QueryField(fieldName: "pfp");
  static final QueryField JOININGDATE = QueryField(fieldName: "joiningDate");
  static final QueryField BALANCE = QueryField(fieldName: "balance");
  static final QueryField KYC = QueryField(fieldName: "kyc");
  static final QueryField SGVERIFIED = QueryField(fieldName: "sgVerified");
  static final QueryField TRANSACTIONS = QueryField(
    fieldName: "transactions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Transaction'));
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
        ]),
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SGID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PINCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PFP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.JOININGDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BALANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.KYC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SGVERIFIED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.TRANSACTIONS,
      isRequired: false,
      ofModelName: 'Transaction',
      associatedKey: Transaction.USERID
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