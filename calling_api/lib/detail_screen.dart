import 'package:calling_api/model/user_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.e});
  final Usermodel e;

  @override
  Widget build(BuildContext context) {
    print(e.first_name);
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            // Text(e.first_name),
            // Text(e.last_name),
            // Text(e.email),
          ],
        ),
      ),
    );
  }
}