import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../feed/domain/entities/post.dart';
import 'models/title.dart';
import 'models/description.dart';
import 'models/price.dart';

class UploadPostState extends Equatable {
  const UploadPostState({
    this.title = const Title.pure(),
    this.description = const Description.pure(),
    this.price = const Price.pure(),
    this.tags = const [],
    this.imagesPath = const [],
    this.status = FormzStatus.pure,
  });

  final Title title;
  final Description description;
  final Price price;
  final List<String> tags;
  final List<String> imagesPath;
  final FormzStatus status;

  UploadPostState copyWith({
    Title? title,
    Description? description,
    Price? price,
    List<String>? tags,
    List<String>? imagesPath,
    FormzStatus? status,
  }) {
    return UploadPostState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      tags: tags ?? this.tags,
      imagesPath: imagesPath ?? this.imagesPath,
    );
  }

  @override
  List<Object> get props =>
      [title, description, price, tags, imagesPath, status];
}
