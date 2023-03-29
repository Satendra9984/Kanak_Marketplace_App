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


/** This is an auto generated class representing the Address type in your schema. */
@immutable
class Address extends Model {
  static const classType = const _AddressModelType();
  final String id;
  final String? _name;
  final int? _pincode;
  final String? _userID;
  final String? _phone;
  final String? _email;
  final String? _address;
  final bool? _status;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  AddressModelIdentifier get modelIdentifier {
      return AddressModelIdentifier(
        id: id
      );
  }
  
  String? get name {
    return _name;
  }
  
  int? get pincode {
    return _pincode;
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
  
  String? get phone {
    return _phone;
  }
  
  String? get email {
    return _email;
  }
  
  String? get address {
    return _address;
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
  
  const Address._internal({required this.id, name, pincode, required userID, phone, email, address, status, createdAt, updatedAt}): _name = name, _pincode = pincode, _userID = userID, _phone = phone, _email = email, _address = address, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Address({String? id, String? name, int? pincode, required String userID, String? phone, String? email, String? address, bool? status}) {
    return Address._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      pincode: pincode,
      userID: userID,
      phone: phone,
      email: email,
      address: address,
      status: status);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Address &&
      id == other.id &&
      _name == other._name &&
      _pincode == other._pincode &&
      _userID == other._userID &&
      _phone == other._phone &&
      _email == other._email &&
      _address == other._address &&
      _status == other._status;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Address {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("pincode=" + (_pincode != null ? _pincode!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("status=" + (_status != null ? _status!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Address copyWith({String? name, int? pincode, String? userID, String? phone, String? email, String? address, bool? status}) {
    return Address._internal(
      id: id,
      name: name ?? this.name,
      pincode: pincode ?? this.pincode,
      userID: userID ?? this.userID,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      status: status ?? this.status);
  }
  
  Address.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _pincode = (json['pincode'] as num?)?.toInt(),
      _userID = json['userID'],
      _phone = json['phone'],
      _email = json['email'],
      _address = json['address'],
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'pincode': _pincode, 'userID': _userID, 'phone': _phone, 'email': _email, 'address': _address, 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'name': _name, 'pincode': _pincode, 'userID': _userID, 'phone': _phone, 'email': _email, 'address': _address, 'status': _status, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<AddressModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<AddressModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Address";
    modelSchemaDefinition.pluralName = "Addresses";
    
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
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.PINCODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.STATUS,
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

class _AddressModelType extends ModelType<Address> {
  const _AddressModelType();
  
  @override
  Address fromJson(Map<String, dynamic> jsonData) {
    return Address.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Address';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Address] in your schema.
 */
@immutable
class AddressModelIdentifier implements ModelIdentifier<Address> {
  final String id;

  /** Create an instance of AddressModelIdentifier using [id] the primary key. */
  const AddressModelIdentifier({
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
  String toString() => 'AddressModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is AddressModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}