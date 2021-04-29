part of 'get_attendance_bloc.dart';

abstract class GetAttendanceEvent extends Equatable {
  const GetAttendanceEvent();
}

class FetchAllAttendanceEvent extends GetAttendanceEvent {
  final String classId;

  FetchAllAttendanceEvent(this.classId);

  @override
  List<Object> get props => [];
}
