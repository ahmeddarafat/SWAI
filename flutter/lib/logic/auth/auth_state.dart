part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthnErrorState extends AuthState {
  final String error;
  AuthnErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthnLoadingState extends AuthState {}

class AuthnSuccessState extends AuthState {}
