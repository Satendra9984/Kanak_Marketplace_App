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


/** This is an auto generated class representing the Transaction type in your schema. */
@immutable
class Transaction extends Model {
  static const classType = const _TransactionModelType();
  final String id;
  final String? _type;
  final int? _amount;
  final String? _userID;
  final String? _details;
  final TemporalDateTime? _datetime;
  final String? _status;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TransactionModelIdentifier get modelIdentifier {
      return TransactionModelIdentifier(
        id: id
      );
  }
  
  String? get type {
    return _type;
  }
  
  int? get amount {
    return _amount;
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
  
  String? get details {
    return _details;
  }
  
  TemporalDateTime? get datetime {
    return _datetime;
  }
  
  String? get status {
    return _status;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Transaction._internal({required this.id, type, amount, required userID, details, datetime, status, createdAt, updatedAt}): _type = type, _amount = amount, _userID = userID, _details = details, _datetime = datetime, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Transaction({String? id, String? type, int? amount, required String userID, String? details, TemporalDateTime? datetime, String? status}) {
    return Transaction._internal(
      id: id == null ? UUID.getUUID() : id,
      type: type,
      amount: amount,
      userID: userID,
      details: details,
      datetime: datetime,
      status: status);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
      id == other.id &&
      _type == other._type &&
      _amount == other._amount &&
      _userID == other._userID &&
      _details == other._details &&
      _datetime == other._datetime &&
      _status == other._status;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("datetime=" + (_datetime != null ? _datetime!.format() : "null") + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transaction copyWith({String? type, int? amount, String? userID, String? details, TemporalDateTime? datetime, String? status}) {
    return Transaction._internal(
      id: id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      userID: userID ?? this.userID,
      details: details ?? this.details,
      datetime: datetime ?? this.datetime,
      status: status ?? this.status);
  }
  
  Transaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _type = json['type'],
      _amount = (json['amount'] as num?)?.toInt(),
      _userID = json['userID'],
      _details = json['details'],
      _datetime = json['datetime'] != null ? TemporalDateTime.fromString(json['datetime']) : null,
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'type': _type, 'amount': _amount, 'userID': _userID, 'details': _details, 'datetime': _datetime?.format(), 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'type': _type, 'amount': _amount, 'userID': _userID, 'details': _details, 'datetime': _datetime, 'status': _status, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<TransactionModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<TransactionModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField DETAILS = QueryField(fieldName: "details");
  static final QueryField DATETIME = QueryField(fieldName: "datetime");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transaction";
    modelSchemaDefinition.pluralName = "Transactions";
    
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
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.AMOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.DETAILS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.STATUS,
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
  });
}

class _TransactionModelType extends ModelType<Transaction> {
  const _TransactionModelType();
  
  @override
  Transaction fromJson(Map<String, dynamic> jsonData) {
    return Transaction.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Transaction';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Transaction] in your schema.
 */
@immutable
class TransactionModelIdentifier implements ModelIdentifier<Transaction> {
  final String id;

  /** Create an instance of TransactionModelIdentifier using [id] the primary key. */
  const TransactionModelIdentifier({
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
  String toString() => 'TransactionModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransactionModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}