part of 'create_class_bloc.dart';

abstract class CreateClassEvent extends Equatable {
  const CreateClassEvent();
}

class CreateNewClassEvent extends CreateClassEvent {
  const CreateNewClassEvent({this.className, this.des});

  final String className;
  final String des;

  @override
  List<Object> get props => [];
}
