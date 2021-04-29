part of 'update_attendance_bloc.dart';

abstract class UpdateAttendanceEvent extends Equatable {
  const UpdateAttendanceEvent();
}

class SignAttendanceEvent extends UpdateAttendanceEvent {
  const SignAttendanceEvent(this.attendanceId);
  final String attendanceId;

  @override
  List<Object> get props => [attendanceId];
}

class FetchAttendanceEvent extends UpdateAttendanceEvent {
  const FetchAttendanceEvent(this.attendanceId);
  final String attendanceId;

  @override
  List<Object> get props => [attendanceId];
}
