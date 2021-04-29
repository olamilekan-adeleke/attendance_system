part of 'update_attendance_bloc.dart';

abstract class UpdateAttendanceState extends Equatable {
  const UpdateAttendanceState();
}

class InitialAttendanceState extends UpdateAttendanceState {
  @override
  List<Object> get props => [];
}

///
class InitialSignAttendanceState extends UpdateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadingSignAttendanceState extends UpdateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadedSignAttendanceState extends UpdateAttendanceState {
  final Map data;

  LoadedSignAttendanceState(this.data);
  @override
  List<Object> get props => [];
}

class ErrorSignAttendanceState extends UpdateAttendanceState {
  final String message;

  ErrorSignAttendanceState(this.message);
  @override
  List<Object> get props => [];
}

///
class InitialFetchAttendanceState extends UpdateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadingFetchAttendanceState extends UpdateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadedFetchAttendanceState extends UpdateAttendanceState {
  final UserThatSignAttendanceModel users;

  LoadedFetchAttendanceState(this.users);
  @override
  List<Object> get props => [];
}

class ErrorFetchAttendanceState extends UpdateAttendanceState {
  final String message;

  ErrorFetchAttendanceState(this.message);
  @override
  List<Object> get props => [];
}
