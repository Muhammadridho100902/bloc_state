import 'package:blc_bildr/bloc/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsumeHome extends StatelessWidget {
  ConsumeHome({Key? key}) : super(key: key);

  CounterBloc myCounter = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // cara cepat penggunaan block builder dan bloc listener yaitu dengan bloc Consumer 
          BlocConsumer(
            bloc: myCounter,
            listenWhen: (previous, current) {
              if (current == 10) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return Center(
                child: Text(
                  "$state",
                  style: const TextStyle(fontSize: 30, color: Colors.green),
                ),
              );
            },
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sudah sampai 10"),
                  duration: Duration(seconds: 2),
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
