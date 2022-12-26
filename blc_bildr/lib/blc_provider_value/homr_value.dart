import 'package:blc_bildr/blc_provider_value/prove_value_home.dart';
import 'package:blc_bildr/bloc/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MyValue());
}

class MyValue extends StatelessWidget {
  const MyValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: ProviderValueHome(),
      ),
    );
  }
}