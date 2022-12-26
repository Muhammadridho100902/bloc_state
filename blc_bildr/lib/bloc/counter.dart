import 'package:bloc/bloc.dart';

class CounterBloc extends Cubit{
  CounterBloc({this.InitialData = 0}) : super(InitialData);

  int InitialData;

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  @override
  void onChange(Change change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }
}