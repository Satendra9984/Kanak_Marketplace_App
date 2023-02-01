class AuthUser {
  final String phone;
  final String email;
  final String? uid;
  const AuthUser({
    required this.email, 
    required this.phone,
    this.uid
  });

  factory AuthUser.fromJson(Map<String, dynamic> data) {
    return AuthUser(
      email: data['email'] ?? '',
      phone: data['phone'] ?? ''
    );
  }
}