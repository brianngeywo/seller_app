class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final String password;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
    );
  }

  factory UserModel.empty() {
    return UserModel(id: '', firstName: 'waiting...', lastName: '', email: '', phoneNumber: 'waiting...', password: '', username: '');

  }
}
