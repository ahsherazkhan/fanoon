import 'package:equatable/equatable.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends UploadPostEvent {
  const TitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends UploadPostEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class PriceChanged extends UploadPostEvent {
  const PriceChanged({required this.price});

  final String price;
  @override
  List<Object> get props => [price];
}

class AddTag extends UploadPostEvent {
  const AddTag({required this.tagName});

  final String tagName;

  @override
  List<Object> get props => [tagName];
}

class RemoveTag extends UploadPostEvent {
  const RemoveTag({required this.tagName});

  final String tagName;

  @override
  List<Object> get props => [tagName];
}

class AddImage extends UploadPostEvent {
  const AddImage({required this.path});

  final List<String> path;

  @override
  List<Object> get props => [path];
}

class RemoveImage extends UploadPostEvent {
  const RemoveImage({required this.path});
  final String path;

  @override
  List<Object> get props => [path];
}

class TitleUnFocused extends UploadPostEvent {}

class DescriptionUnFocused extends UploadPostEvent {}

class PriceUnFocused extends UploadPostEvent {}

class CreatePost extends UploadPostEvent {
  @override
  List<Object> get props => [];
}
