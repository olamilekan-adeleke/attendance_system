import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/student/repo/student_repo.dart';

part 'register_class_event.dart';
part 'register_class_state.dart';

class RegisterClassBloc extends Bloc<RegisterClassEvent, RegisterClassState> {
  RegisterClassBloc() : super(InitialRegisterClassState());

  @override
  Stream<RegisterClassState> mapEventToState(
    RegisterClassEvent event,
  ) async* {
    if (event is RegisterForAClassEvent) {
      try {
        yield LoadingRegisterClassState();
        final Map data =
            await StudentRepo().registerForAClass(classId: event.classId);
        yield LoadedRegisterClassState(data);
      } catch (e, s) {
        yield ErrorRegisterClassState(e?.message.toString());
      }
    }
  }
}
