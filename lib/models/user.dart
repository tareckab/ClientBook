class User {
  final String id;
  final String name;
  final String avatar;
  final String country;
  final String city;
  final DateTime createdAt;





//entidade e atributos de User (api)

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.country,
    required this.city,
    required this.createdAt,
  });



// "??" retorna o valor a esquerda se ele nao for nulo se nao utiliza a string fazia
//fromMap cria um objeto User (responsavel por formatar em json)
//dynamic é um tipo que aceita qualquer valor (string, int,  etc)

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

// converte objeto em mapa (ler json)
  Map<String, dynamic> toMap() => {
        'name': name,
        'avatar': avatar,
        'country': country,
        'city': city,
        // createdAt é gerado pelo servidor normalmente
      };
}
