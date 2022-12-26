import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeper/bloc/app_block.dart';
import 'package:keeper/bloc/app_event.dart';
import 'package:keeper/bloc/app_state.dart';
import 'package:keeper/page/home.dart';
// import 'package:keeper/page/home.dart';
import 'package:keeper/repo/note_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => KeeperRepository(),
        child: HomeMain(),
      ),
      // home: MultiRepositoryProvider(
      //   providers: [
      //     RepositoryProvider(
      //       create: (context) => KeeperRepository(),
      //       child: Home(),
      //     ),
      //     RepositoryProvider(
      //       create: (context) => KeeperRepository(),
      //       child: HomeStation(),
      //     )
      //   ],
      //   child: HomeStation(),
      // ),
    );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => KeepBlock(
          keeperRepository:RepositoryProvider.of<KeeperRepository>(context)
      ),
      child: Scaffold(
          // key: scaffoldKey,
          body: BlocListener<KeepBlock, KeepState>(
              listener: (context, state) {
                if (state is KeepAdded) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Keep added"), duration: Duration(seconds: 2),));
                }
              },
              child: BlocBuilder<KeepBlock, KeepState>(
                builder: (context, state) {
                  if (state is KeepAdding) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is KeepError){
                    return const Center(child:Text("Error"));
                  }
                  return const HomeStation();
                },
              )
          )
      ),
    );
  }
}

class HomeStation extends StatefulWidget {
  const HomeStation({Key? key}) : super(key: key);

  @override
  _HomeStationState createState() => _HomeStationState();
}

class _HomeStationState extends State<HomeStation> {
// text fields' controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _universiryController = TextEditingController();

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _universiryController,
                  decoration: const InputDecoration(
                    labelText: 'University',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    String? name = _usernameController.text;
                    final String university = _universiryController.text;
                    if (name.isNotEmpty) {
                      _postData(context);

                      _usernameController.text = '';
                      _universiryController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  void _postData(context) {
    BlocProvider.of<KeepBlock>(context).add(
      Create(
          username: _usernameController.text,
          university: _universiryController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
