import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funoon/features/feed/domain/repositories/feed_repository.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository feedRepository;

  FeedBloc(this.feedRepository) : super(FeedLoading()) {
    on<LoadFeed>(_loadFeed);
    on<RefreshFeed>(_refreshFeed);
  }

  Future<void> _loadFeed(
    LoadFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    final posts = await feedRepository.getAllPosts();

    posts.fold(
      (failure) => emit(
        FeedNotLoaded(
          _mapFailureToMessage(failure),
        ),
      ),
      (posts) => emit(
        FeedLoaded(posts),
      ),
    );
  }

  Future<void> _refreshFeed(
    RefreshFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    final posts = await feedRepository.getAllPosts();

    posts.fold(
      (failure) => emit(
        FeedNotLoaded(_mapFailureToMessage(failure)),
      ),
      (posts) => emit(
        FeedLoaded(posts),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      case CacheFailure:
        return 'CACHE_FAILURE_MESSAGE';
      default:
        return 'Unexpected error';
    }
  }
}
