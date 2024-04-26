class UserData {
  final int id;
  final String fullName;
  final String email;
  final String username;
  // Ajoutez d'autres propriétés utilisateur selon vos besoins

  UserData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.username,
    // Initialisez d'autres propriétés ici
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      username: json['username'],
      // Associez d'autres propriétés ici
    );
  }
}
