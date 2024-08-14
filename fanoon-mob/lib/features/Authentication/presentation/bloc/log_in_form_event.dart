part of 'log_in_form_bloc.dart';

abstract class LogInFormEvent extends Equatable {
  const LogInFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LogInFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}




class PasswordChanged extends LogInFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}


class VisibilityChanged extends LogInFormEvent {
  final bool isVisible;

  const VisibilityChanged({required this.isVisible});
}

class EmailUnfocused extends LogInFormEvent {}
class PasswordUnfocused extends LogInFormEvent {}

class FormSubmitted extends LogInFormEvent {}
class DisposePage extends LogInFormEvent {}