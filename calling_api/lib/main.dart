import 'package:calling_api/bloc/user_bloc.dart';
import 'package:calling_api/detail_screen.dart';
import 'package:calling_api/model/apiRepository.dart';
import 'package:calling_api/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => ApiRepository(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<ApiRepository>(context),
      )..add(
          LoadingUserEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Api Bloc"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<Usermodel> userList = state.users;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(e: userList[index]),));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      color: Colors.blue,
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          userList[index].first_name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          userList[index].last_name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: const Icon(Icons.person, size: 30),
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
