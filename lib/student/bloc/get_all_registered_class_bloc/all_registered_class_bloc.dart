import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_project/student/model/regisgeter_class_Model.dart';
import 'package:school_project/student/repo/student_repo.dart';

part 'all_registered_class_event.dart';
part 'all_registered_class_state.dart';

class AllRegisteredClassBloc
    extends Bloc<AllRegisteredClassEvent, AllRegisteredClassState> {
  AllRegisteredClassBloc() : super(InitialAllRegisteredClassState());

  @override
  Stream<AllRegisteredClassState> mapEventToState(
    AllRegisteredClassEvent event,
  ) async* {
    if (event is FetchAllRegisteredClassEvent) {
      try {
        yield LoadingAllRegisteredClassState();
        List data = await StudentRepo().getClass();
        List<RegisteredClassModel> classes =
            data.map((e) => RegisteredClassModel.fromJson(e)).toList();
        yield LoadedAllRegisteredClassState(classes);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorAllRegisteredClassState(e?.message.toString());
      }
    }
  }
}
