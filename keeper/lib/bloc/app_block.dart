import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeper/bloc/app_event.dart';
import 'package:keeper/bloc/app_state.dart';
import 'package:keeper/repo/note_repo.dart';

class KeepBlock extends Bloc<KeepEvent, KeepState> {
  final KeeperRepository keeperRepository;
  KeepBlock({required this.keeperRepository}) : super(InitialState()){
    on<Create>((event, emit) async {
      emit(KeepAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await keeperRepository.create(username: event.username, univeristy: event.university);
        emit(KeepAdded());
      } catch (e) {
        emit(KeepError(error: e.toString()));
      }
    });
  }
}