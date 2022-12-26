import 'dart:async';

class CounterBloc {

  int _counter = 0;

  int get counter => _counter;

  final StreamController _inputController = StreamController();
  StreamSink get sinkIn => _inputController.sink;

  final StreamController _outputController = StreamController();
  StreamSink get sinkOut => _outputController.sink;

  Stream get outPut => _outputController.stream;

  CounterBloc() {
    _inputController.stream.listen(
      (event) {
        if (event == 'add') {
          _counter++;
        } else{
          _counter--;
        }
        sinkOut.add(_counter);
      },
    );
  }
  void dispose() {
    _inputController.close();
    _outputController.close();
  }
}
