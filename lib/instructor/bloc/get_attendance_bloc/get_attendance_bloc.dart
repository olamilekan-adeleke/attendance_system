import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/instructor/model/attendance_model.dart';
import 'package:school_project/instructor/repo/instructor_repo.dart';

part 'get_attendance_event.dart';
part 'get_attendance_state.dart';

class GetAttendanceBloc extends Bloc<GetAttendanceEvent, GetAttendanceState> {
  GetAttendanceBloc() : super(InitialGetAttendanceState());

  @override
  Stream<GetAttendanceState> mapEventToState(
    GetAttendanceEvent event,
  ) async* {
    if (event is FetchAllAttendanceEvent) {
      try {
        yield LoadingGetAttendanceState();
        final List<AttendanceModel> attendance =
            await InstructorRepo().getAllAttendance(event.classId);
        yield LoadedGetAttendanceState(attendance);
      } catch (e, s) {
        print(e);
        print(s);

        yield ErrorGetAttendanceState(e?.message.toString());
      }
    }
  }
}
