import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    CounterBloc myCounter = context.read<CounterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Value"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, dynamic>(
          bloc: myCounter,
          builder: (context, state) {
            return Text("$state", style: const TextStyle(fontSize: 50),);
          },
        ),
      ),
    );
  }
}
