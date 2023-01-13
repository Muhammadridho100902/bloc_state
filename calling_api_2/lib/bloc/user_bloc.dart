import 'package:bloc/bloc.dart';
import 'package:calling_api_2/model/api_repo.dart';
import 'package:calling_api_2/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadingUserEvent>((event, emit) async {
      try {
        final users = await _userRepository.getAllData();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(
          UserErrorState(
            e.toString(),
          ),
        );
      }
    });
  }
}
