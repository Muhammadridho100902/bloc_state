import 'dart:developer';

import 'package:blc_bildr/bloc/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataCenter extends StatelessWidget {
  const DataCenter({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
  // cara 1
  // CounterBloc myCounter = BlocProvider.of<CounterBloc>(context);
  // cara 2
  CounterBloc myCounter = context.read<CounterBloc>();
    return Center(
        child: BlocBuilder(
      bloc: myCounter,
      builder: (context, state) {
        return Text(
          "$state",
          style: const TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        );
      },
    ));
  }
}
