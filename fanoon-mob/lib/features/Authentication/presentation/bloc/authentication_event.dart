part of 'authentication_bloc.dart';

enum AuthenticationStatus {authenticated, signupPage ,loginPage , unAuthenticated}

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged({required this.user});

  final User user;
 //final AuthenticationStatus status;

  @override
  List<Object> get props => [user];
  
}

class NavigateToLoginPage extends AuthenticationEvent {
  
}

class NavigateToSignupPage extends AuthenticationEvent {
  
}
class AuthenticationLogoutRequested extends AuthenticationEvent {
  
}
