import 'dart:io';

import 'package:funoon/features/profile/data/datasources/API/profile_api_service.dart';

import '../../../../feed/domain/entities/post.dart';

abstract class ProfileApi {
  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/Signup endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Post> createPost({
    required String title,
    required String description,
    required int price,
    required List<String> images,
    required List<String> tags,
  });
}

class ProfileApiImpl extends ProfileApi {
  final profileSerivce = ProfileService();

  @override
  Future<Post> createPost({
    required String title,
    required String description,
    required int price,
    required List<String> images,
    required List<String> tags,
  }) async {
    final post = await profileSerivce.createPost(
      title: title,
      description: description,
      price: price,
      images: images,
      tags: tags,
    );

    return post;
  }
}
