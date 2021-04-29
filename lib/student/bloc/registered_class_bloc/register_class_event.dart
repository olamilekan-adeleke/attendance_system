part of 'register_class_bloc.dart';

abstract class RegisterClassEvent extends Equatable {
  const RegisterClassEvent();
}

class RegisterForAClassEvent extends RegisterClassEvent {
  final String classId;

  RegisterForAClassEvent(this.classId);

  @override
  List<Object> get props => [classId];
}
