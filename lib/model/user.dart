class User {
  final int id;
  final String username;
  final String email;
  final String lastname;
  final String firstname;
  final String gender;
  final String image;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.gender,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ,
      username: json['username'] ,
      email: json['email'] ,
      lastname: json['lastName'] , 
      firstname: json['firstName'] , 
      gender: json['gender'] ,
      image: json['image'] ,
    );
  }
}
