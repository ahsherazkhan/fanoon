import 'package:funoon/features/Authentication/data/models/user.dart';

import '../../domain/entities/post.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.description,
    required super.likes,
    required super.likesIDs,
    required super.comments,
    required super.shares,
    required super.isSold,
    required super.images,
    required super.imagesUrls,
    required super.price,
    required super.tags,
    required super.createdBy,
    required super.dateCreated,
    required super.sharesIDs,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        likes: json["likes"],
        likesIDs: List<String>.from(json["likesIDs"].map((x) => x)),
        comments: List<String>.from(json["comments"].map((x) => x)),
        shares: json["shares"],
        isSold: json["isSold"],
        images: List<String>.from(json["images"].map((x) => x)),
        imagesUrls: List<String>.from(json["imagesUrls"].map((x) => x)),
        price: json["price"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        createdBy: UserModel.fromJsonPost(json["createdBy"]),
        dateCreated: json["dateCreated"],
        sharesIDs: List<String>.from(json["sharesIDs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "likes": likes,
        "likesIDs": List<dynamic>.from(likesIDs.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "shares": shares,
        "isSold": isSold,
        "images": List<dynamic>.from(images.map((x) => x)),
        "imagesUrls": List<dynamic>.from(imagesUrls.map((x) => x)),
        "price": price,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "createdBy": createdBy,
        "dateCreated": dateCreated,
        "sharesIDs": List<dynamic>.from(sharesIDs.map((x) => x)),
      };
}
