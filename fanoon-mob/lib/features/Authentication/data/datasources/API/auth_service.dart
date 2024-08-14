import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funoon/core/error/expections.dart';
import 'package:funoon/features/Authentication/data/models/user.dart';

import '../../../domain/entities/user.dart';
import '../../../../../core/network_manger.dart';

class AuthService {
  var dio = NetworkManager.instance();
  var secureStorage = const FlutterSecureStorage();

  Future<User> signup({required Map<String, String> body}) async {
    Response response = await dio.post(
      options: Options(),
      '/users/Signup',
      data: body,
    );
    if (response.statusCode == 201) {
      final user = UserModel.fromJson(response.data);

      //-----------stores the responses token in the sercure storage
      await secureStorage.write(key: 'token', value: response.data['token']);
      return user;
    } else {
      throw ServerException();
    }
  }

  Future<User> login({required Map<String, String> body}) async {
    Response response = await dio.post(
      '/users/login',
      data: body,
    );
    if (response.statusCode == 200) {
      final user = UserModel.fromJson(response.data);
      //-----------stores the responses token in the sercure storage
      await secureStorage.write(key: 'token', value: response.data['token']);
      return user;
    } else {
      throw ServerException();
    }
  }
}
