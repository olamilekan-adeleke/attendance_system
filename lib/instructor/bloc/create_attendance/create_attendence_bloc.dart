import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/instructor/repo/instructor_repo.dart';

part 'create_attendence_event.dart';

part 'create_attendence_state.dart';

class CreateAttendanceBloc
    extends Bloc<CreateAttendanceEvent, CreateAttendanceState> {
  CreateAttendanceBloc() : super(InitialCreateAttendanceState());

  @override
  Stream<CreateAttendanceState> mapEventToState(
    CreateAttendanceEvent event,
  ) async* {
    if (event is MakeAttendanceEvent) {
      try {
        yield LoadingCreateAttendanceState();
        final Map<String, dynamic> data =
            await InstructorRepo().createAttendance(
          className: event.className,
          description: event.description,
          endDate: event.endDate,
        );
        yield LoadedCreateAttendanceState(data);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorCreateAttendanceState(e != null ? e?.message.toString() : 'Error: $e');
      }
    }
  }
}
