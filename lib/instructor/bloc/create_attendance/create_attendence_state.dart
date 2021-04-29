part of 'create_attendence_bloc.dart';

abstract class CreateAttendanceState extends Equatable {
  const CreateAttendanceState();
}

class InitialCreateAttendanceState extends CreateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadingCreateAttendanceState extends CreateAttendanceState {
  @override
  List<Object> get props => [];
}

class LoadedCreateAttendanceState extends CreateAttendanceState {
  const LoadedCreateAttendanceState(this.data);

  final Map<String, dynamic> data;
  @override
  List<Object> get props => [];
}

class ErrorCreateAttendanceState extends CreateAttendanceState {
  const ErrorCreateAttendanceState(this.message);

  final String message;

  @override
  List<Object> get props => [];
}

