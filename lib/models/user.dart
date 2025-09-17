class User {
  final String id;
  final String name;
  final String avatar;
  final String country;
  final String city;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.country,
    required this.city,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'avatar': avatar,
        'country': country,
        'city': city,
        // createdAt é gerado pelo servidor normalmente; envie se precisar
      };
}
