import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int>{
  CounterCubit({this.initialData = 0}) : super(initialData);
  
  int initialData;

  // int? current;
  // int? next;

  void plus(){
    emit(state + 1);
  }

  void minus(){
    emit(state - 1);
  }

  // materi observer
  // untuk memantau data
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    // current = change.currentState;
    // next = change.nextState;
  }

}