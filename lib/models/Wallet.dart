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


/** This is an auto generated class representing the Wallet type in your schema. */
@immutable
class Wallet extends Model {
  static const classType = const _WalletModelType();
  final String id;
  final double? _balance;
  final double? _gold_balance;
  final String? _address;
  final List<Transaction>? _transactions;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  WalletModelIdentifier get modelIdentifier {
      return WalletModelIdentifier(
        id: id
      );
  }
  
  double? get balance {
    return _balance;
  }
  
  double? get gold_balance {
    return _gold_balance;
  }
  
  String? get address {
    return _address;
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
  
  const Wallet._internal({required this.id, balance, gold_balance, address, transactions, createdAt, updatedAt}): _balance = balance, _gold_balance = gold_balance, _address = address, _transactions = transactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Wallet({String? id, double? balance, double? gold_balance, String? address, List<Transaction>? transactions}) {
    return Wallet._internal(
      id: id == null ? UUID.getUUID() : id,
      balance: balance,
      gold_balance: gold_balance,
      address: address,
      transactions: transactions != null ? List<Transaction>.unmodifiable(transactions) : transactions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Wallet &&
      id == other.id &&
      _balance == other._balance &&
      _gold_balance == other._gold_balance &&
      _address == other._address &&
      DeepCollectionEquality().equals(_transactions, other._transactions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Wallet {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("balance=" + (_balance != null ? _balance!.toString() : "null") + ", ");
    buffer.write("gold_balance=" + (_gold_balance != null ? _gold_balance!.toString() : "null") + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Wallet copyWith({double? balance, double? gold_balance, String? address, List<Transaction>? transactions}) {
    return Wallet._internal(
      id: id,
      balance: balance ?? this.balance,
      gold_balance: gold_balance ?? this.gold_balance,
      address: address ?? this.address,
      transactions: transactions ?? this.transactions);
  }
  
  Wallet.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _balance = (json['balance'] as num?)?.toDouble(),
      _gold_balance = (json['gold_balance'] as num?)?.toDouble(),
      _address = json['address'],
      _transactions = json['transactions'] is List
        ? (json['transactions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Transaction.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'balance': _balance, 'gold_balance': _gold_balance, 'address': _address, 'transactions': _transactions?.map((Transaction? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'balance': _balance, 'gold_balance': _gold_balance, 'address': _address, 'transactions': _transactions, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<WalletModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<WalletModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField BALANCE = QueryField(fieldName: "balance");
  static final QueryField GOLD_BALANCE = QueryField(fieldName: "gold_balance");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField TRANSACTIONS = QueryField(
    fieldName: "transactions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Transaction'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Wallet";
    modelSchemaDefinition.pluralName = "Wallets";
    
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
      key: Wallet.BALANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wallet.GOLD_BALANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wallet.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Wallet.TRANSACTIONS,
      isRequired: false,
      ofModelName: 'Transaction',
      associatedKey: Transaction.RECEIVER
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

class _WalletModelType extends ModelType<Wallet> {
  const _WalletModelType();
  
  @override
  Wallet fromJson(Map<String, dynamic> jsonData) {
    return Wallet.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Wallet';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Wallet] in your schema.
 */
@immutable
class WalletModelIdentifier implements ModelIdentifier<Wallet> {
  final String id;

  /** Create an instance of WalletModelIdentifier using [id] the primary key. */
  const WalletModelIdentifier({
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
  String toString() => 'WalletModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is WalletModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}