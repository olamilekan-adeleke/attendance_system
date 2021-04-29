part of 'create_attendence_bloc.dart';

abstract class CreateAttendanceEvent extends Equatable {
  const CreateAttendanceEvent();
}

class MakeAttendanceEvent extends CreateAttendanceEvent{
  const MakeAttendanceEvent({this.className, this.description, this.endDate});

  final String className;
  final String description;
  final String endDate;

  @override
  List<Object> get props => [];
}