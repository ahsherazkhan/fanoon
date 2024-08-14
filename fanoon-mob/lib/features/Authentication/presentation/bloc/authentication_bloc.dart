import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/models/user.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthRepositoryImplementation authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unAuthenticated()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<NavigateToLoginPage>(_onLoginPage);
    on<NavigateToSignupPage>(_onSignupPage);

    //------------Listens to the changes in the Login, Signup and Logout Events---------------
    _authenticationStatusSubscription =
        _authenticationRepository.user.listen((user) {
      if (state.user == User.empty) {
        add(AuthenticationStatusChanged(user: user));
      } else {
        add(AuthenticationStatusChanged(user: state.user));
      }
    });
  }

  final AuthRepositoryImplementation _authenticationRepository;
  late StreamSubscription<User> _authenticationStatusSubscription;

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      event.user == User.empty
          ? const AuthenticationState.unAuthenticated()
          : AuthenticationState.authenticated(event.user),
    );
  }

  Future<void> _onSignupPage(
    NavigateToSignupPage event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.signup());
  }


  Future<void> _onLoginPage(
    NavigateToLoginPage event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.login());
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(const AuthenticationState.unAuthenticated());
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    log('This is the bloc JSON \n : $json');
    if (json.isEmpty) {
      return const AuthenticationState.signup();
    } else {
      return AuthenticationState.authenticated(
        UserModel.fromJson(json),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state.user == User.empty) {
      return {};
    } else {
      final body = {
        'data': UserModel(
          id: state.user.id,
          name: state.user.name,
          email: state.user.email,
          active: state.user.active,
          isVerified: state.user.isVerified,
          role: state.user.role,
        ).toJson(),
      };
      return body;
    }
  }
}
