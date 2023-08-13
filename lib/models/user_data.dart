class User {
  final String username;
  final String name;
  final String token;

  User({
    required this.username,
    required this.name,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['usuario']['id'],
        name: json['usuario']['nombre'],
        token: json['result']);
  }
}
