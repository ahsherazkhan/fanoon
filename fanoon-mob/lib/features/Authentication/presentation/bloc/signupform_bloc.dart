import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:funoon/core/error/failures.dart';

import '../../domain/usecases/signup_auth.dart';
import 'models/email.dart';
import 'models/password.dart';
import 'models/username.dart';

part 'signupform_event.dart';
part 'signupform_state.dart';

class SignupFormBloc extends Bloc<SignupformEvent, SignupFormState> {
  SignupFormBloc({required this.signupUsecase})
      : super(const SignupFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<UsernameUnfocused>(_onUsernameUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<VisibilityChanged>(_onVisibiltyChanged);
    on<DisposePage>(_onDisposePage);
  }

  late StreamSubscription authStatusStreamSubscription;
  final SignUp signupUsecase;

  void _onVisibiltyChanged(
      VisibilityChanged event, Emitter<SignupFormState> emit) {
    final isVisible = event.isVisible;
    emit(
      state.copyWith(
        isVisible: !isVisible,
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupFormState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password, state.username]),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SignupFormState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, state.username, password]),
      ),
    );
  }

  void _onUsernameChanged(
      UsernameChanged event, Emitter<SignupFormState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username.valid ? username : Username.pure(event.username),
      status: Formz.validate([state.email, state.password, username]),
    ));
  }

  //-------Focus of text fields changes
  void _onEmailUnfocused(EmailUnfocused event, Emitter<SignupFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onUsernameUnfocused(
      UsernameUnfocused event, Emitter<SignupFormState> emit) {
    final username = Username.dirty(state.username.value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password, state.email]),
      ),
    );
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<SignupFormState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<SignupFormState> emit,
  ) async {
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        username: username,
        email: email,
        password: password,
        status: Formz.validate([email, password, username]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      //------------------UseCase of Repository------------------
      final result = await signupUsecase(Params(
        name: state.username.value,
        email: state.email.value,
        password: state.password.value,
      ));

      await Future<void>.delayed(const Duration(seconds: 1));

      result.fold(
        (failure) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        },
        (user) => emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        ),
      );
    }
  }

  void _onDisposePage(
    DisposePage event,
    Emitter<SignupFormState> emit,
  ) {
    emit(const SignupFormState());
  }
}
