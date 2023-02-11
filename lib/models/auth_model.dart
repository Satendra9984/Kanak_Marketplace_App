import 'package:flutter/material.dart';

enum AuthStatus {
  loggedin,
  loggedout
}

@immutable
class AuthUserModel {
  final String? phone;
  final String? email;
  final String? id;
  final AuthStatus? authStatus;
  const AuthUserModel({
    this.email, 
    this.phone,
    this.id,
    this.authStatus
  });
  AuthUserModel copyWith({
    String? email, 
    String? phone,
    String? id,
    AuthStatus? authStatus
  }) {
    return AuthUserModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      authStatus: authStatus ?? this.authStatus
    );
  }
}