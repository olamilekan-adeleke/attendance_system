part of 'get_all_classes_bloc.dart';

abstract class GetAllClassesState extends Equatable {
  const GetAllClassesState();
}

class InitialGetAllClassesState extends GetAllClassesState {
  @override
  List<Object> get props => [];
}

class LoadingGetAllClassesState extends GetAllClassesState {
  @override
  List<Object> get props => [];
}

class LoadedGetAllClassesState extends GetAllClassesState {
  final List<ClassModel> classes;

  LoadedGetAllClassesState(this.classes);
  @override
  List<Object> get props => [];
}

class ErrorGetAllClassesState extends GetAllClassesState {
  final String message;

  ErrorGetAllClassesState(this.message);

  @override
  List<Object> get props => [];
}
