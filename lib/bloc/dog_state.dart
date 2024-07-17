import 'package:api_request/model/dog.dart';
import 'package:equatable/equatable.dart';

abstract class DogState extends Equatable {
  const DogState();

  @override
  List<Object?> get props => [];
}

class DogInitialState extends DogState {}

class DogLoadingState extends DogState {}

class DogLoadedState extends DogState {
  final List<Dog> dogs;

  DogLoadedState(this.dogs);

  @override
  List<Object?> get props => [dogs];
}

class DogErrorState extends DogState {
  final String error;

  DogErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
