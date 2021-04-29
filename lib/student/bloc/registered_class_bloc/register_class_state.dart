part of 'register_class_bloc.dart';

abstract class RegisterClassState extends Equatable {
  const RegisterClassState();
}

class InitialRegisterClassState extends RegisterClassState {
  @override
  List<Object> get props => [];
}

class LoadingRegisterClassState extends RegisterClassState {
  @override
  List<Object> get props => [];
}

class LoadedRegisterClassState extends RegisterClassState {
  final Map data;

  LoadedRegisterClassState(this.data);
  @override
  List<Object> get props => [];
}

class ErrorRegisterClassState extends RegisterClassState {
  final String message;

  ErrorRegisterClassState(this.message);
  @override
  List<Object> get props => [];
}

