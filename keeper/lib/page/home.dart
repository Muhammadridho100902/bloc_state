import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeper/bloc/app_block.dart';
import 'package:keeper/bloc/app_state.dart';
import 'package:keeper/main.dart';
import 'package:keeper/page/add.dart';
import 'package:keeper/repo/note_repo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => KeepBlock(
          keeperRepository: RepositoryProvider.of<KeeperRepository>(context)),
      child: Scaffold(
        key: ScaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Keeper"),
        ),
        body: BlocListener(
          listener: (context, state) {
            if (state is KeepAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Data Added"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder(
            builder: (context, state) {
              if (state is KeepAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is KeepError) {
                return const Center(child: Text("Error"));
              }
              return const HomeStation();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddPage(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
