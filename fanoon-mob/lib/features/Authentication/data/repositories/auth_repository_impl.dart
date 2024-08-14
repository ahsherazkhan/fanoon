import 'package:dartz/dartz.dart';
import 'package:funoon/app/theme/colors.dart';
import 'package:funoon/features/Authentication/data/models/user.dart';
import 'dart:async';

import '../../../../core/error/expections.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

import '../datasources/API/auth_api.dart';

class AuthRepositoryImplementation extends AuthRepository {
  AuthRepositoryImplementation({required this.authAPIImpl});

  final AuthAPIImpl authAPIImpl;
  final _controller = StreamController<User>();
  bool isSignedIn = false;
  User userFromApi = User.empty;

  @override
  Future<Either<Failure, User>> login(
      {required String password, required String email}) async {
    try {
      userFromApi = await authAPIImpl.login(email: email, password: password);
      _controller.add(userFromApi);
      isSignedIn = true;

      return Right(userFromApi);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signup({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      userFromApi = await authAPIImpl.signup(
          name: name, password: password, email: email);
      _controller.add(userFromApi);
      return Right(userFromApi);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  void dispose() {
    isSignedIn = false;
    _controller.close();
  }

  @override
  Stream<User> get user async* {
    yield User.empty;
    yield* _controller.stream;
  }
}
