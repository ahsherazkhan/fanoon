import 'package:funoon/features/feed/domain/usecases/get_all_posts.dart';

import '../../../domain/entities/post.dart';
import 'feed_api_service.dart';
import 'feed_service.dart';

abstract class FeedApi {
  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/Signup endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Post>> getAllPosts();

  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/posts/like endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> likePost({required String id});
}

class FeedApiImpl implements FeedApi {
  final feedService = FeedService();

  @override
  Future<List<Post>> getAllPosts() {
    return feedService.getAllPosts();
  }

  @override
  Future<void> likePost({required String id}) {
    return feedService.likePost(id: id);
  }
}
