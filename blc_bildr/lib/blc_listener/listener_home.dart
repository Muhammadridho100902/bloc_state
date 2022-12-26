import 'package:blc_bildr/bloc/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListenerHome extends StatelessWidget {
  ListenerHome({Key? key}) : super(key: key);

  CounterBloc myCounter = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<CounterBloc, dynamic>(
            bloc: myCounter,
            listenWhen: (previous, current) {
              if (current == 10) {
                return true;
              } else {
                return false;
              }
            },
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sudah sampai 10"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: BlocBuilder<CounterBloc, dynamic>(
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
                    style: const TextStyle(fontSize: 30, color: Colors.red),
                  ),
                );
              },
            ),
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
