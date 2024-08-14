import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funoon/features/Authentication/domain/entities/user.dart';
import 'package:funoon/features/Authentication/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class Login implements UseCase<User, Params> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.login(
      password: params.password,
      email: params.email,
    );
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
