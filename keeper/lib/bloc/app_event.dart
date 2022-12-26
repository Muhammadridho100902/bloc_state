import 'package:equatable/equatable.dart';

abstract class KeepEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class Create extends KeepEvent{
  final String username;
  final String university;

  Create({required this.username, required this.university});
}