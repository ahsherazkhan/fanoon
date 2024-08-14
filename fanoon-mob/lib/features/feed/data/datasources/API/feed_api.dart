import '../../../domain/entities/post.dart';
import 'feed_api_service.dart';

abstract class FeedApi {
  /// Calls the https://scarlet-scrubs.cyclic.app/api/v1/posts endpoint.
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
  Future<List<Post>> getAllPosts() async {
    return await feedService.getAllPosts();
  }

  @override
  Future<void> likePost({required String id}) async {
    await feedService.likePost(id: id);
  }
}
