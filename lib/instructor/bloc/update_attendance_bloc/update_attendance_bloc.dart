import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/instructor/model/user_that_sign.dart';
import 'package:school_project/instructor/repo/instructor_repo.dart';
import 'package:school_project/student/repo/student_repo.dart';

part 'update_attendance_event.dart';
part 'update_attendance_state.dart';

class UpdateAttendanceBloc
    extends Bloc<UpdateAttendanceEvent, UpdateAttendanceState> {
  UpdateAttendanceBloc() : super(InitialAttendanceState());

  @override
  Stream<UpdateAttendanceState> mapEventToState(
    UpdateAttendanceEvent event,
  ) async* {
    if (event is SignAttendanceEvent) {
      try {
        yield LoadingSignAttendanceState();
        final Map<String, dynamic> data =
            await StudentRepo().signAttendance(event.attendanceId);
        yield LoadedSignAttendanceState(data);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorSignAttendanceState(e?.message.toString());
      }
    } else if (event is FetchAttendanceEvent) {
      try {
        yield LoadingFetchAttendanceState();
        final UserThatSignAttendanceModel users = await InstructorRepo()
            .fetchAllUserSignAttendance(event.attendanceId);
        yield LoadedFetchAttendanceState(users);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorFetchAttendanceState(e.toString());
      }
    }
  }
}
