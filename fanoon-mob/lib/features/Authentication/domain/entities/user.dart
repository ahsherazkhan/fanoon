import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool active;
  final bool isVerified;


  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.active,
    required this.isVerified,
  });

  static const empty = User(
    id: '',
    name: '',
    email: '',
    role: '',
    active: false,
    isVerified: false,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        role,
        active,
        isVerified,
      ];
}
