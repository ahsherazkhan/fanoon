import 'package:funoon/features/feed/domain/entities/post.dart';
import 'package:funoon/core/error/failures.dart';
import '../../../../core/error/expections.dart';
import '../../domain/respositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/API/profile_api.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.profileApi});

  final ProfileApi profileApi;
  @override
  Future<Either<Failure, Post>> createPost({
    required String title,
    required String description,
    required int price,
    required List<String> images,
    required List<String> tags,
  }) async {
    try {
      final post = await profileApi.createPost(
        title: title,
        description: description,
        price: price,
        images: images,
        tags: tags,
      );
      return Right(post);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}















// {
//     "status": "success",
//     "data": {
//         "data": {
//             "title": "Crying Cat",
//             "description": "Roti hoi sad bili",
//             "likes": 0,
//             "likesIDs": [],
//             "shares": 0,
//             "sharesIDs": [],
//             "isSold": false,
//             "images": [
//                 "post-1667407421285.jpg",
//                 "post-1667407421299.jpg"
//             ],
//             "imagesUrls": [],
//             "price": 20,
//             "tags": [],
//             "createdBy": "63629e29a98a07ad58a42879",
//             "_id": "63629e3daec62a63b8e25333",
//             "comments": [],
//             "dateCreated": "2022-11-02T16:43:41.441Z",
//             "__v": 0
//         }
//     }
// }