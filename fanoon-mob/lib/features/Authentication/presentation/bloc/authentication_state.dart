part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unAuthenticated,
    required this.user,
  });

  const AuthenticationState.unAuthenticated()
      : this._(status: AuthenticationStatus.unAuthenticated,user: User.empty);

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.signup()
      : this._(status: AuthenticationStatus.signupPage, user: User.empty);

  const AuthenticationState.login()
      : this._(status: AuthenticationStatus.loginPage, user: User.empty);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
