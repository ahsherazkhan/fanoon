import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funoon/core/error/expections.dart';
import 'package:funoon/features/feed/data/models/post_model.dart';

import '../../../../../core/network_manger.dart';
import '../../../domain/entities/post.dart';

class FeedService {
  var dio = NetworkManager.instance();
  final secureStorage = const FlutterSecureStorage();

  Future<List<Post>> getAllPosts() async {
    //using try catch here to propagate DIO expections
    try {
      Response response = await dio.get(
        '/posts',
      );
      if (response.statusCode == 200) {
        List<dynamic> data = (response.data['data']['postsWithUrls']);
        List<Post> posts = [];
        log(data.toString());
        for (var element in data) {
          final temp = PostModel.fromJson(element);
          posts.add(temp);
        }
        return posts;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> likePost({required String id}) async {
    Map<String, String> body = {'postId': id};
    // get token from the storage
    String? token = await secureStorage.read(key: 'token');
    //using try catch here to propagate DIO expections
    try {
      Response response = await dio.put(
        '/posts/like',
        data: body,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
