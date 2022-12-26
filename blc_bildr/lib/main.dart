import 'package:blc_bildr/blc_consume/consume_home.dart';
import 'package:blc_bildr/blc_provider/provider_home.dart';
import 'package:blc_bildr/blc_provider_value/prove_value_home.dart';
import 'package:blc_bildr/bloc/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProviderValueHome(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  CounterBloc myCounter = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder(
            bloc: myCounter,
            // buildWhen: (previous, current) {
            //   if (current == 5) {
            //     return true;
            //   } else{
            //     return false;
            //   }
            // },
            builder: (context, state) {
              return Center(
                child: Text(
                  "$state",
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  myCounter.increment();
                },
                icon: const Icon(Icons.add),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  myCounter.decrement();
                },
                icon: const Icon(Icons.remove),
                iconSize: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
