class User {
  const User(
      {required this.status,
      required this.selfieBaseString,
      required this.isHost});

  final String status;
  final String selfieBaseString;
  final bool isHost;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['status'],
      selfieBaseString: json['selfieBaseString'],
      isHost: json['isAdmin'],
    );
  }
}
