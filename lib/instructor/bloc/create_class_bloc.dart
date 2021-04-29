import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/instructor/repo/instructor_repo.dart';

part 'create_class_event.dart';
part 'create_class_state.dart';

class CreateClassBloc extends Bloc<CreateClassEvent, CreateClassState> {
  CreateClassBloc() : super(InitialCreateClassState());

  @override
  Stream<CreateClassState> mapEventToState(
    CreateClassEvent event,
  ) async* {
    if (event is CreateNewClassEvent) {
      try {
        yield LoadingCreateClassState();
        final Map<String, dynamic> data = await InstructorRepo().createClass(
          className: event.className,
          description: event.des,
        );
        yield LoadedCreateClassState(data);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorCreateClassState(e?.message.toString());
      }
    }
  }
}
