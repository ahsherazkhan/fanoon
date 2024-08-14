import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funoon/core/error/failures.dart';
import 'package:funoon/features/feed/domain/entities/post.dart';
import 'package:funoon/features/profile/domain/respositories/profile_repository.dart';
import '../../../../core/usecase/usecase.dart';

class CreatePostUsecase implements UseCase<Post, Params> {
  final ProfileRepository repository;

  CreatePostUsecase(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) {
    return repository.createPost(
      title: params.title,
      description: params.description,
      price: params.price,
      images: params.images,
      tags: params.tags,
    );
  }
}

class Params extends Equatable {
  final String title;
  final String description;
  final int price;
  final List<String> images;
  final List<String> tags;

  const Params({
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.tags,
  });

  @override
  List<Object?> get props => throw [title, price, description, images, tags];
}
