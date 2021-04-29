part of 'create_class_bloc.dart';

abstract class CreateClassState extends Equatable {
  const CreateClassState();
}

class InitialCreateClassState extends CreateClassState {
  @override
  List<Object> get props => [];
}

class LoadingCreateClassState extends CreateClassState {
  @override
  List<Object> get props => [];
}

class LoadedCreateClassState extends CreateClassState {
  const LoadedCreateClassState(this.data);

  final Map<String, dynamic> data;
  @override
  List<Object> get props => [];
}

class ErrorCreateClassState extends CreateClassState {
  const ErrorCreateClassState(this.message);

  final String message;
  @override
  List<Object> get props => [];
}
