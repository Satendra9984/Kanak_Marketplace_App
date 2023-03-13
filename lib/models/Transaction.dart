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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Transaction type in your schema. */
@immutable
class Transaction extends Model {
  static const classType = const _TransactionModelType();
  final String id;
  final TransactionType? _type;
  final double? _amount;
  final TransactionStatus? _status;
  final TemporalDateTime? _dateTime;
  final Wallet? _receiver;
  final Wallet? _sender;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _transactionReceiverId;
  final String? _transactionSenderId;

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
  
  TransactionType? get type {
    return _type;
  }
  
  double? get amount {
    return _amount;
  }
  
  TransactionStatus? get status {
    return _status;
  }
  
  TemporalDateTime? get dateTime {
    return _dateTime;
  }
  
  Wallet? get receiver {
    return _receiver;
  }
  
  Wallet? get sender {
    return _sender;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get transactionReceiverId {
    return _transactionReceiverId;
  }
  
  String? get transactionSenderId {
    return _transactionSenderId;
  }
  
  const Transaction._internal({required this.id, type, amount, status, dateTime, receiver, sender, createdAt, updatedAt, transactionReceiverId, transactionSenderId}): _type = type, _amount = amount, _status = status, _dateTime = dateTime, _receiver = receiver, _sender = sender, _createdAt = createdAt, _updatedAt = updatedAt, _transactionReceiverId = transactionReceiverId, _transactionSenderId = transactionSenderId;
  
  factory Transaction({String? id, TransactionType? type, double? amount, TransactionStatus? status, TemporalDateTime? dateTime, Wallet? receiver, Wallet? sender, String? transactionReceiverId, String? transactionSenderId}) {
    return Transaction._internal(
      id: id == null ? UUID.getUUID() : id,
      type: type,
      amount: amount,
      status: status,
      dateTime: dateTime,
      receiver: receiver,
      sender: sender,
      transactionReceiverId: transactionReceiverId,
      transactionSenderId: transactionSenderId);
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
      _status == other._status &&
      _dateTime == other._dateTime &&
      _receiver == other._receiver &&
      _sender == other._sender &&
      _transactionReceiverId == other._transactionReceiverId &&
      _transactionSenderId == other._transactionSenderId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("transactionReceiverId=" + "$_transactionReceiverId" + ", ");
    buffer.write("transactionSenderId=" + "$_transactionSenderId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transaction copyWith({TransactionType? type, double? amount, TransactionStatus? status, TemporalDateTime? dateTime, Wallet? receiver, Wallet? sender, String? transactionReceiverId, String? transactionSenderId}) {
    return Transaction._internal(
      id: id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
      transactionReceiverId: transactionReceiverId ?? this.transactionReceiverId,
      transactionSenderId: transactionSenderId ?? this.transactionSenderId);
  }
  
  Transaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _type = enumFromString<TransactionType>(json['type'], TransactionType.values),
      _amount = (json['amount'] as num?)?.toDouble(),
      _status = enumFromString<TransactionStatus>(json['status'], TransactionStatus.values),
      _dateTime = json['dateTime'] != null ? TemporalDateTime.fromString(json['dateTime']) : null,
      _receiver = json['receiver']?['serializedData'] != null
        ? Wallet.fromJson(new Map<String, dynamic>.from(json['receiver']['serializedData']))
        : null,
      _sender = json['sender']?['serializedData'] != null
        ? Wallet.fromJson(new Map<String, dynamic>.from(json['sender']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _transactionReceiverId = json['transactionReceiverId'],
      _transactionSenderId = json['transactionSenderId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'type': enumToString(_type), 'amount': _amount, 'status': enumToString(_status), 'dateTime': _dateTime?.format(), 'receiver': _receiver?.toJson(), 'sender': _sender?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'transactionReceiverId': _transactionReceiverId, 'transactionSenderId': _transactionSenderId
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'type': _type, 'amount': _amount, 'status': _status, 'dateTime': _dateTime, 'receiver': _receiver, 'sender': _sender, 'createdAt': _createdAt, 'updatedAt': _updatedAt, 'transactionReceiverId': _transactionReceiverId, 'transactionSenderId': _transactionSenderId
  };

  static final QueryModelIdentifier<TransactionModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<TransactionModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static final QueryField RECEIVER = QueryField(
    fieldName: "receiver",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Wallet'));
  static final QueryField SENDER = QueryField(
    fieldName: "sender",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Wallet'));
  static final QueryField TRANSACTIONRECEIVERID = QueryField(fieldName: "transactionReceiverId");
  static final QueryField TRANSACTIONSENDERID = QueryField(fieldName: "transactionSenderId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transaction";
    modelSchemaDefinition.pluralName = "Transactions";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.AMOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Transaction.RECEIVER,
      isRequired: false,
      ofModelName: 'Wallet',
      associatedKey: Wallet.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Transaction.SENDER,
      isRequired: false,
      ofModelName: 'Wallet',
      associatedKey: Wallet.ID
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
      key: Transaction.TRANSACTIONRECEIVERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transaction.TRANSACTIONSENDERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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