part of 'log_in_form_bloc.dart';

class LogInFormState extends Equatable {
  const LogInFormState({
    this.isVisible = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final bool isVisible;

  LogInFormState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    Username? username,
    bool? isVisible,
  }) {
    return LogInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object> get props => [email, password, status, isVisible];
}
