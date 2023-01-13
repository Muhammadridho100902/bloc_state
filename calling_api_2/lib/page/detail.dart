import 'package:calling_api_2/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.e});

  final Usermodel e;

  @override
  Widget build(BuildContext context) {
    UserBloc myBloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Value"),
      ),
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          bloc: myBloc,
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              return Text(
                e.first_name,
                style: const TextStyle(fontSize: 50),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
