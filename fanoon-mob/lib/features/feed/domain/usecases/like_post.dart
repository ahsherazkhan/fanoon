import 'package:equatable/equatable.dart';
import 'package:funoon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:funoon/features/feed/domain/repositories/feed_repository.dart';

import '../../../../core/usecase/usecase.dart';

class LikePost implements UseCase<void, Params> {
  final FeedRepository repository;
  LikePost(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.likePost(id: params.postId);
  }
}

class Params extends Equatable {
  final String postId;

  const Params({required this.postId});

  @override
  List<Object?> get props => [postId];
}
