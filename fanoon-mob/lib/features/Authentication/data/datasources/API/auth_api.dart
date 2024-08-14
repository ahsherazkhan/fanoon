import 'dart:convert';

import 'package:funoon/features/Authentication/data/models/user.dart';

import 'auth_service.dart';
import '../../../domain/entities/user.dart';
import '../../../../../core/error/expections.dart';

abstract class AuthAPI {
  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/Signup endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> signup({
    required String name,
    required String email,
    required String password,
  });

  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/Login endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> login({
    required String email,
    required String password,
  });
}

class AuthAPIImpl implements AuthAPI {
  final authService = AuthService();

  @override
  Future<User> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
    };

    final user = await authService.signup(body: body);

    return user;
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };

    final user = await authService.login(body: body);

    return user;
  }
}
