import 'package:dartz/dartz.dart';
import 'package:funoon/core/error/failures.dart';

import '../../../feed/domain/entities/post.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Post>> createPost({
    required String title,
    required String description,
    required int price,
    required List<String> images,
    required List<String> tags,
  });
}
