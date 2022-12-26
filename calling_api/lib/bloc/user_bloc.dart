import 'package:bloc/bloc.dart';
import 'package:calling_api/model/apiRepository.dart';
import 'package:calling_api/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadingUserEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        final users = await _userRepository.getCallApi();
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
