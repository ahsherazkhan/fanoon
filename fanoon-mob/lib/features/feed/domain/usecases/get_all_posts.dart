import 'package:funoon/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:funoon/features/feed/domain/repositories/feed_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/post.dart';

class GetAllPosts implements UseCase<List<Post>, NoParams> {
  final FeedRepository repository;
  GetAllPosts(this.repository);
  
  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async{
    return repository.getAllPosts();
  }

}
