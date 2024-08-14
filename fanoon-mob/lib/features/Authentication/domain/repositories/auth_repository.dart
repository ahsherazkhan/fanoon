import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure,User>> signup({required String name, required String password, required String email});
  Future<Either<Failure,User>> login({required String password, required String email});
  Stream<User> get user;
}
