part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  const FeedLoaded(this.posts);

  FeedLoaded copyWith({
    List<Post>? posts,
  }) {
    return FeedLoaded(
      posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];
}

class FeedNotLoaded extends FeedState {
  //message to for the not feed loaded scenario
  final String message;

  const FeedNotLoaded(this.message);
}
