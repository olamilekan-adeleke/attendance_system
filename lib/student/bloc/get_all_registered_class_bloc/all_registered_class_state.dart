part of 'all_registered_class_bloc.dart';

abstract class AllRegisteredClassState extends Equatable {
  const AllRegisteredClassState();
}

class InitialAllRegisteredClassState extends AllRegisteredClassState {
  @override
  List<Object> get props => [];
}

class LoadingAllRegisteredClassState extends AllRegisteredClassState {
  @override
  List<Object> get props => [];
}

class LoadedAllRegisteredClassState extends AllRegisteredClassState {
  final List classes;

  LoadedAllRegisteredClassState(this.classes);

  @override
  List<Object> get props => [];
}

class ErrorAllRegisteredClassState extends AllRegisteredClassState {
  const ErrorAllRegisteredClassState(this.message);

  final String message;
  @override
  List<Object> get props => [];
}
