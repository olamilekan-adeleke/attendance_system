import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/create_class_bloc.dart';
import 'package:school_project/instructor/bloc/get_all_classes/get_all_classes_bloc.dart';
import 'package:school_project/instructor/bloc/get_attendance_bloc/get_attendance_bloc.dart';
import 'package:school_project/instructor/bloc/update_attendance_bloc/update_attendance_bloc.dart';
import 'package:school_project/student/bloc/get_all_registered_class_bloc/all_registered_class_bloc.dart';
import 'package:school_project/student/bloc/registered_class_bloc/register_class_bloc.dart';

import 'instructor/bloc/create_attendance/create_attendence_bloc.dart';

List<BlocProvider> blocLis(BuildContext context) {
  return <BlocProvider>[
    BlocProvider<GetAllClassesBloc>(
        create: (context) => GetAllClassesBloc()..add(FetchAllClassesEvent())),
    BlocProvider<CreateClassBloc>(create: (context) => CreateClassBloc()),
    BlocProvider<RegisterClassBloc>(create: (context) => RegisterClassBloc()),
    BlocProvider<GetAttendanceBloc>(create: (context) => GetAttendanceBloc()),
    BlocProvider<UpdateAttendanceBloc>(
        create: (context) => UpdateAttendanceBloc()),
    BlocProvider<CreateAttendanceBloc>(
        create: (context) => CreateAttendanceBloc()),
    BlocProvider<AllRegisteredClassBloc>(
        create: (context) =>
            AllRegisteredClassBloc()..add(FetchAllRegisteredClassEvent())),
  ];
}
