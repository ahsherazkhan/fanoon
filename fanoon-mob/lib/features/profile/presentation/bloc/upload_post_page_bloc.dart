import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:funoon/features/profile/domain/usecases/create_post.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post__page_event.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post__page_state.dart';

import 'models/description.dart';
import 'models/price.dart';
import 'models/title.dart';

class UploadPostPageBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostPageBloc({required this.createPostUsecase})
      : super(const UploadPostState()) {
    on<TitleChanged>(_onTitleChange);
    on<DescriptionChanged>(_onDescriptionChange);
    on<PriceChanged>(_onPriceChange);
    on<TitleUnFocused>(_onTitleUnfocused);
    on<DescriptionUnFocused>(_onDescriptionUnfocused);
    on<PriceUnFocused>(_onPriceUnfocused);
    on<AddTag>(_onAddTag);
    on<RemoveTag>(_onRemoveTag);
    on<AddImage>(_onAddImage);
    on<RemoveImage>(_onRemoveImage);
    on<CreatePost>(_onCreatePost);
  }

  final CreatePostUsecase createPostUsecase;

  void _onTitleChange(TitleChanged event, Emitter<UploadPostState> emit) {
    final title = Title.dirty(event.title);
    emit(
      state.copyWith(
        title: title.valid ? title : Title.pure(event.title),
        status: Formz.validate([title, state.description, state.price]),
      ),
    );
  }

  void _onDescriptionChange(
      DescriptionChanged event, Emitter<UploadPostState> emit) {
    final description = Description.dirty(event.description);

    emit(state.copyWith(
        description: description.valid
            ? description
            : Description.pure(event.description),
        status: Formz.validate([description, state.title, state.price])));
  }

  void _onPriceChange(PriceChanged event, Emitter<UploadPostState> emit) {
    final price = Price.dirty(event.price);
    emit(
      state.copyWith(
          price: price.valid ? price : Price.pure(event.price),
          status: Formz.validate([price, state.title, state.description])),
    );
  }

  void _onAddTag(AddTag event, Emitter<UploadPostState> emit) {
    if (!state.tags.contains(event.tagName)) {
      // creating a new List so that both objects don't point to same memory and this UI won't rebuilt
      List<String> tags = [event.tagName];
      for (var element in state.tags) {
        tags.add(element);
      }
      emit(state.copyWith(
        tags: tags,
      ));
    }
  }

  void _onRemoveTag(RemoveTag event, Emitter<UploadPostState> emit) {
    // creating a new List so that both objects don't point to same memory and this UI won't rebuilt
    List<String> tags = [];
    for (var element in state.tags) {
      tags.add(element);
    }
    tags.remove(event.tagName);
    emit(state.copyWith(
      tags: tags,
    ));
  }

  void _onAddImage(AddImage event, Emitter<UploadPostState> emit) {
    List<String> imagesPath = event.path;

    emit(state.copyWith(
      imagesPath: imagesPath,
    ));
  }

  void _onRemoveImage(RemoveImage event, Emitter<UploadPostState> emit) {
    List<String> paths = [];
    for (var element in state.imagesPath) {
      paths.add(element);
    }
    paths.remove(event.path);
    emit(state.copyWith(
      imagesPath: paths,
    ));
  }

  void _onTitleUnfocused(TitleUnFocused event, Emitter<UploadPostState> emit) {
    final title = Title.dirty(state.title.value);
    emit(
      state.copyWith(
        title: title,
        status: Formz.validate([title, state.description, state.price]),
      ),
    );
  }

  void _onDescriptionUnfocused(
      DescriptionUnFocused event, Emitter<UploadPostState> emit) {
    final description = Description.dirty(state.description.value);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate([description, state.title, state.price]),
      ),
    );
  }

  void _onPriceUnfocused(PriceUnFocused event, Emitter<UploadPostState> emit) {
    final price = Price.dirty(state.price.value);
    emit(
      state.copyWith(
        price: price,
        status: Formz.validate([price, state.title, state.description]),
      ),
    );
  }

  void _onCreatePost(CreatePost event, Emitter<UploadPostState> emit) async {
    //UseCase CreatePost

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    //Usecase of the Profile Respositry
    final result = await createPostUsecase(
      Params(
        title: state.title.value,
        price: int.parse(state.price.value),
        description: state.description.value,
        images: state.imagesPath,
        tags: state.tags,
      ),
    );

    result.fold((failure) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }, (post) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      emit(const UploadPostState());
    });
  }
}
