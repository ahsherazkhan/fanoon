// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:equatable/equatable.dart';

import '../../../Authentication/domain/entities/user.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.likes,
    required this.likesIDs,
    required this.comments,
    required this.shares,
    required this.isSold,
    required this.images,
    required this.price,
    required this.tags,
    required this.createdBy,
    required this.dateCreated,
    required this.sharesIDs,
    required this.imagesUrls,
  });

  final String id;
  final String title;
  final String description;
  final int likes;
  final List<String> likesIDs;
  final List<String> comments;
  final int shares;
  final bool isSold;
  final List<String> images;
  final List<String> imagesUrls;
  final int price;
  final List<String> tags;
  final User createdBy;
  final String dateCreated;
  final List<String> sharesIDs;

  static const empty = Post(
    id: '',
    title: '',
    description: '',
    likes: 0,
    likesIDs: [],
    comments: [],
    shares: 0,
    isSold: false,
    images: [],
    price: 0,
    tags: [],
    createdBy: User.empty,
    dateCreated: '',
    sharesIDs: [],
    imagesUrls: [],
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        likes,
        likesIDs,
        comments,
        shares,
        isSold,
        images,
        price,
        tags,
        createdBy,
        dateCreated,
        sharesIDs,
        imagesUrls,
      ];
}
