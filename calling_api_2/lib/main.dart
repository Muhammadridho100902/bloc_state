import 'package:calling_api_2/bloc/user_bloc.dart';
import 'package:calling_api_2/model/api_repo.dart';
import 'package:calling_api_2/model/user_model.dart';
import 'package:calling_api_2/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiRepository _userRepository = ApiRepository();
    return RepositoryProvider(
      create: (context) => _userRepository,
      child: BlocProvider(
        create: (context) => UserBloc(RepositoryProvider.of<ApiRepository>(context))..add(LoadingUserEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
