part of 'signupform_bloc.dart';

class SignupFormState extends Equatable {
  const SignupFormState({
    this.isVisible = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Username username;
  final FormzStatus status;
  final bool isVisible;

  //----------------copyWith()-----------------------------------------
  //Instead of mutating or copying an object, you can use copyWith() to 
  //create a new object with the same properties as the original, but 
  //with some of the values changed
  //-------------------------------------------------------------------
  
  SignupFormState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    Username? username,
    bool? isVisible,
  }) {
    return SignupFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      username: username ?? this.username,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object> get props => [email, password, username, status, isVisible];
}
