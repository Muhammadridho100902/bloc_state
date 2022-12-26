import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/**
 * Konsep Stream adalah melempar data ke dalam suatu aliran menggunakan yield
 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Stream<int> countSteam() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(
        const Duration(seconds: 2),
      );
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: countSteam(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("${snapshot.data}");
          }
        },
      )),
    );
  }
}
