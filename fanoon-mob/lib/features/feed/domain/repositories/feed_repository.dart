import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, void>> likePost({required String id});
}
