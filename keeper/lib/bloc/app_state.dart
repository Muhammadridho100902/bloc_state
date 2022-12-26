import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class KeepState extends Equatable {}

class InitialState extends KeepState {
  @override
  List<Object> get props => [];
}

class KeepAdding extends KeepState {
  @override
  List<Object> get props => [];
}

class KeepAdded extends KeepState {
  @override
  List<Object> get props => [];
}

class KeepError extends KeepState {
  final String error;
  KeepError({required this.error});

  @override
  List<Object> get props => [error];
}
