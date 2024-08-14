import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funoon/features/Authentication/domain/entities/user.dart';
import 'package:funoon/features/Authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class SignUp implements UseCase<User, Params> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.signup(
      name: params.name,
      password: params.password,
      email: params.email,
    );
  }
}

class Params extends Equatable {
  final String name;
  final String email;
  final String password;
  const Params(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}
