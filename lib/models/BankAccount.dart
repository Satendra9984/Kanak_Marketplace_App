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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the BankAccount type in your schema. */
@immutable
class BankAccount extends Model {
  static const classType = const _BankAccountModelType();
  final String id;
  final String? _bankId;
  final String? _accNo;
  final String? _ifsc;
  final String? _addressId;
  final String? _accName;
  final String? _userID;
  final bool? _status;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BankAccountModelIdentifier get modelIdentifier {
      return BankAccountModelIdentifier(
        id: id
      );
  }
  
  String? get bankId {
    return _bankId;
  }
  
  String? get accNo {
    return _accNo;
  }
  
  String? get ifsc {
    return _ifsc;
  }
  
  String? get addressId {
    return _addressId;
  }
  
  String? get accName {
    return _accName;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get status {
    return _status;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const BankAccount._internal({required this.id, bankId, accNo, ifsc, addressId, accName, required userID, status, createdAt, updatedAt}): _bankId = bankId, _accNo = accNo, _ifsc = ifsc, _addressId = addressId, _accName = accName, _userID = userID, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BankAccount({String? id, String? bankId, String? accNo, String? ifsc, String? addressId, String? accName, required String userID, bool? status}) {
    return BankAccount._internal(
      id: id == null ? UUID.getUUID() : id,
      bankId: bankId,
      accNo: accNo,
      ifsc: ifsc,
      addressId: addressId,
      accName: accName,
      userID: userID,
      status: status);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccount &&
      id == other.id &&
      _bankId == other._bankId &&
      _accNo == other._accNo &&
      _ifsc == other._ifsc &&
      _addressId == other._addressId &&
      _accName == other._accName &&
      _userID == other._userID &&
      _status == other._status;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BankAccount {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("bankId=" + "$_bankId" + ", ");
    buffer.write("accNo=" + "$_accNo" + ", ");
    buffer.write("ifsc=" + "$_ifsc" + ", ");
    buffer.write("addressId=" + "$_addressId" + ", ");
    buffer.write("accName=" + "$_accName" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("status=" + (_status != null ? _status!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BankAccount copyWith({String? bankId, String? accNo, String? ifsc, String? addressId, String? accName, String? userID, bool? status}) {
    return BankAccount._internal(
      id: id,
      bankId: bankId ?? this.bankId,
      accNo: accNo ?? this.accNo,
      ifsc: ifsc ?? this.ifsc,
      addressId: addressId ?? this.addressId,
      accName: accName ?? this.accName,
      userID: userID ?? this.userID,
      status: status ?? this.status);
  }
  
  BankAccount.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bankId = json['bankId'],
      _accNo = json['accNo'],
      _ifsc = json['ifsc'],
      _addressId = json['addressId'],
      _accName = json['accName'],
      _userID = json['userID'],
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bankId': _bankId, 'accNo': _accNo, 'ifsc': _ifsc, 'addressId': _addressId, 'accName': _accName, 'userID': _userID, 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'bankId': _bankId, 'accNo': _accNo, 'ifsc': _ifsc, 'addressId': _addressId, 'accName': _accName, 'userID': _userID, 'status': _status, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<BankAccountModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<BankAccountModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField BANKID = QueryField(fieldName: "bankId");
  static final QueryField ACCNO = QueryField(fieldName: "accNo");
  static final QueryField IFSC = QueryField(fieldName: "ifsc");
  static final QueryField ADDRESSID = QueryField(fieldName: "addressId");
  static final QueryField ACCNAME = QueryField(fieldName: "accName");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BankAccount";
    modelSchemaDefinition.pluralName = "BankAccounts";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: const [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.BANKID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.ACCNO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.IFSC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.ADDRESSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.ACCNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BankAccount.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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

class _BankAccountModelType extends ModelType<BankAccount> {
  const _BankAccountModelType();
  
  @override
  BankAccount fromJson(Map<String, dynamic> jsonData) {
    return BankAccount.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'BankAccount';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [BankAccount] in your schema.
 */
@immutable
class BankAccountModelIdentifier implements ModelIdentifier<BankAccount> {
  final String id;

  /** Create an instance of BankAccountModelIdentifier using [id] the primary key. */
  const BankAccountModelIdentifier({
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
  String toString() => 'BankAccountModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BankAccountModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}