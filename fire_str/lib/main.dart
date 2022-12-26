import 'package:fire_str/bloc/app_bloc.dart';
import 'package:fire_str/bloc/app_event.dart';
import 'package:fire_str/bloc/app_state.dart';
import 'package:fire_str/repo/product_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home:  RepositoryProvider(
          create: (context) => ProductRepo(),
          child: const Home(),
        )
    );
  }
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => ProductBlock(
          productRepo:RepositoryProvider.of<ProductRepo>(context)
      ),
      child: Scaffold(
          // key: scaffoldKey,
          body: BlocListener<ProductBlock, ProductState>(
              listener: (context, state) {
                if (state is ProductAdded) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Product added"), duration: Duration(seconds: 2),));
                }
              },
              child: BlocBuilder<ProductBlock, ProductState>(
                builder: (context, state) {
                  if (state is ProductAdding) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is ProductError){
                    return const Center(child:Text("Error"));
                  }
                  return const HomePage();
                },
              )
          )
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();


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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                    double.tryParse(_priceController.text);
                    if (price != null) {
                      _postData(context);

                      _nameController.text = '';
                      _nameController.text = '';
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


    BlocProvider.of<ProductBlock>(context).add(
      Create(name:  _nameController.text, price:_priceController.text),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
