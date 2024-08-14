part of 'signupform_bloc.dart';

//-------EQUATABLE PACKAGE-----------------------
//Equatable overrides == operator and hashCode for you
//so you don't have to waste your time writing lots of boilerplate code.
//----------------------------------------------------------------------
abstract class SignupformEvent extends Equatable {
  const SignupformEvent();
  //-----What is props-----------------------
  //Props property decides which objects we should consider for object comparison
  //Props is a getter method that will return List<Object>
  //-----------------------------------------------------------------------------
  @override
  List<Object> get props => [];
}

class EmailChanged extends SignupformEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignupformEvent {}

class PasswordChanged extends SignupformEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends SignupformEvent {}

class UsernameChanged extends SignupformEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class VisibilityChanged extends SignupformEvent {
  final bool isVisible;

  const VisibilityChanged({required this.isVisible});
}

class UsernameUnfocused extends SignupformEvent {}

class FormSubmitted extends SignupformEvent {}

class DisposePage extends SignupformEvent {}
