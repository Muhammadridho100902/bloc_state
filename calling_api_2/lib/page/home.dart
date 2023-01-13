import 'package:calling_api_2/bloc/user_bloc.dart';
import 'package:calling_api_2/model/user_model.dart';
import 'package:calling_api_2/page/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild");

    UserBloc myBloc = context.read<UserBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calling Api"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: myBloc,
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserLoadedState) {
            List<Usermodel> userList = state.users;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(e: userList[index]),));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider.value(value: myBloc, child: DetailPage(e: userList[index],),),
                    ));
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
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
    );
  }
}
