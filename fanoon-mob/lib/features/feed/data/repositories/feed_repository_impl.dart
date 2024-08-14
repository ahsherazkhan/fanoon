import 'package:funoon/core/error/expections.dart';
import 'package:funoon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:funoon/features/feed/domain/entities/post.dart';
import 'package:funoon/features/feed/domain/repositories/feed_repository.dart';

import '../datasources/API/feed_api.dart';

class FeedRepositoryImpl extends FeedRepository {
  FeedRepositoryImpl(this.feedAPIImpl);
  final FeedApiImpl feedAPIImpl;

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    try {
      final posts = await feedAPIImpl.getAllPosts();
      return Right(posts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likePost({required String id}) async {
    try {
      await feedAPIImpl.likePost(id: id);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
