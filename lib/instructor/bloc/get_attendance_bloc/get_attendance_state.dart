part of 'get_attendance_bloc.dart';

abstract class GetAttendanceState extends Equatable {
  const GetAttendanceState();
}

class InitialGetAttendanceState extends GetAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadingGetAttendanceState extends GetAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadedGetAttendanceState extends GetAttendanceState {
  final List<AttendanceModel> attendance;

  LoadedGetAttendanceState(this.attendance);
  @override
  List<Object> get props => [];
}

class ErrorGetAttendanceState extends GetAttendanceState {
  final String message;

  ErrorGetAttendanceState(this.message);
  @override
  List<Object> get props => [];
}
