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


/** This is an auto generated class representing the MarketRate type in your schema. */
@immutable
class MarketRate extends Model {
  static const classType = const _MarketRateModelType();
  final String id;
  final TemporalDateTime? _dateTime;
  final String? _blockId;
  final double? _sell;
  final double? _buy;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MarketRateModelIdentifier get modelIdentifier {
      return MarketRateModelIdentifier(
        id: id
      );
  }
  
  TemporalDateTime? get dateTime {
    return _dateTime;
  }
  
  String get blockId {
    try {
      return _blockId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get sell {
    try {
      return _sell!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get buy {
    try {
      return _buy!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const MarketRate._internal({required this.id, dateTime, required blockId, required sell, required buy, createdAt, updatedAt}): _dateTime = dateTime, _blockId = blockId, _sell = sell, _buy = buy, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MarketRate({String? id, TemporalDateTime? dateTime, required String blockId, required double sell, required double buy}) {
    return MarketRate._internal(
      id: id == null ? UUID.getUUID() : id,
      dateTime: dateTime,
      blockId: blockId,
      sell: sell,
      buy: buy);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MarketRate &&
      id == other.id &&
      _dateTime == other._dateTime &&
      _blockId == other._blockId &&
      _sell == other._sell &&
      _buy == other._buy;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MarketRate {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("blockId=" + "$_blockId" + ", ");
    buffer.write("sell=" + (_sell != null ? _sell!.toString() : "null") + ", ");
    buffer.write("buy=" + (_buy != null ? _buy!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MarketRate copyWith({TemporalDateTime? dateTime, String? blockId, double? sell, double? buy}) {
    return MarketRate._internal(
      id: id,
      dateTime: dateTime ?? this.dateTime,
      blockId: blockId ?? this.blockId,
      sell: sell ?? this.sell,
      buy: buy ?? this.buy);
  }
  
  MarketRate.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _dateTime = json['dateTime'] != null ? TemporalDateTime.fromString(json['dateTime']) : null,
      _blockId = json['blockId'],
      _sell = (json['sell'] as num?)?.toDouble(),
      _buy = (json['buy'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'dateTime': _dateTime?.format(), 'blockId': _blockId, 'sell': _sell, 'buy': _buy, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'dateTime': _dateTime, 'blockId': _blockId, 'sell': _sell, 'buy': _buy, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<MarketRateModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<MarketRateModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static final QueryField BLOCKID = QueryField(fieldName: "blockId");
  static final QueryField SELL = QueryField(fieldName: "sell");
  static final QueryField BUY = QueryField(fieldName: "buy");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MarketRate";
    modelSchemaDefinition.pluralName = "MarketRates";
    
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
      key: MarketRate.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MarketRate.BLOCKID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MarketRate.SELL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MarketRate.BUY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
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

class _MarketRateModelType extends ModelType<MarketRate> {
  const _MarketRateModelType();
  
  @override
  MarketRate fromJson(Map<String, dynamic> jsonData) {
    return MarketRate.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'MarketRate';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [MarketRate] in your schema.
 */
@immutable
class MarketRateModelIdentifier implements ModelIdentifier<MarketRate> {
  final String id;

  /** Create an instance of MarketRateModelIdentifier using [id] the primary key. */
  const MarketRateModelIdentifier({
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
  String toString() => 'MarketRateModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is MarketRateModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}