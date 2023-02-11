import 'dart:ffi';

class User {
  const User(
      {required this.status,
      required this.selfieByteString,
      required this.isHost});

  final String status;
  final String selfieByteString;
  final Bool isHost;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['status'],
      selfieByteString: json['selfieByteString'],
      isHost: json['isAdmin'],
    );
  }
}
