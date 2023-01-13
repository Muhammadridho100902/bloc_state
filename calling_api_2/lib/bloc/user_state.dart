part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// loading state
class UserLoadingState extends UserState{
  @override
  List<Object> get props => [];
}

// loaded state
class UserLoadedState extends UserState{
  final List<Usermodel> users;
  const UserLoadedState(this.users);

  @override
  List<Object> get Props => [users];
}

// data error loaded state
class UserErrorState extends UserState{
  final String error;
  const UserErrorState(this.error);

  @override
  List<Object> get Props => [error];
}