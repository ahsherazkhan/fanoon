import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../domain/usecases/login_auth.dart';
import 'models/models.dart';

part 'log_in_form_event.dart';
part 'log_in_form_state.dart';

class LogInFormBloc extends Bloc<LogInFormEvent, LogInFormState> {
  LogInFormBloc({required this.loginUsecase}) : super(const LogInFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
    on<VisibilityChanged>(_onVisibiltyChanged);
    on<DisposePage>(_onDisposePage);
  }
  final Login loginUsecase;
  void _onVisibiltyChanged(
      VisibilityChanged event, Emitter<LogInFormState> emit) {
    final isVisible = event.isVisible;
    emit(
      state.copyWith(
        isVisible: !isVisible,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LogInFormState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<LogInFormState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  //-------Focus of text fields changes
  void _onEmailUnfocused(EmailUnfocused event, Emitter<LogInFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<LogInFormState> emit,
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
    Emitter<LogInFormState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      //------------------UseCase of Repository------------------
      final result = await loginUsecase(Params(
        email: state.email.value,
        password: state.password.value,
      ));

      await Future<void>.delayed(const Duration(seconds: 1));

      result.fold((failure) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }, (user) {
        emit(
          state.copyWith(status: FormzStatus.submissionSuccess),
        );
      });
    }
  }

  void _onDisposePage(
    DisposePage event,
    Emitter<LogInFormState> emit,
  ) {
    emit(const LogInFormState());
  }
}
