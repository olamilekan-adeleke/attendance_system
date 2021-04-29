import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/instructor/model/class_model.dart';
import 'package:school_project/instructor/repo/instructor_repo.dart';

part 'get_all_classes_event.dart';
part 'get_all_classes_state.dart';

class GetAllClassesBloc extends Bloc<GetAllClassesEvent, GetAllClassesState> {
  GetAllClassesBloc() : super(InitialGetAllClassesState());

  @override
  Stream<GetAllClassesState> mapEventToState(
    GetAllClassesEvent event,
  ) async* {
    if (event is FetchAllClassesEvent) {
      try {
        yield LoadingGetAllClassesState();
        final List<ClassModel> classes = (await InstructorRepo().getAllClass())
            .map((e) => ClassModel.fromJson(e))
            .toList();
        yield LoadedGetAllClassesState(classes);
      } catch (e, s) {
        print(e);
        print(s);

        yield ErrorGetAllClassesState(e?.message.toString());
      }
    }
  }
}
