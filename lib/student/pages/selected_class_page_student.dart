import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/get_attendance_bloc/get_attendance_bloc.dart';
import 'package:school_project/instructor/model/attendance_model.dart';
import 'package:school_project/student/model/regisgeter_class_Model.dart';
import 'package:school_project/student/pages/selected_attendance_page_student.dart';

class SelectedClassPageStudent extends StatelessWidget {
  const SelectedClassPageStudent(this.classModel);

  final RegisteredClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ClassInfoWidgetStudent(classModel.classId),
          AttendanceListWidgetStudent(classModel.classId.sId),
        ],
      ),
    );
  }
}

class AttendanceListWidgetStudent extends StatefulWidget {
  const AttendanceListWidgetStudent(this.classId);

  final String classId;

  @override
  _AttendanceListWidgetStudentState createState() =>
      _AttendanceListWidgetStudentState();
}

class _AttendanceListWidgetStudentState
    extends State<AttendanceListWidgetStudent> {
  @override
  void initState() {
    BlocProvider.of<GetAttendanceBloc>(context)
        .add(FetchAllAttendanceEvent(widget.classId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Text('Attendance'),
        Divider(),
        BlocConsumer<GetAttendanceBloc, GetAttendanceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedGetAttendanceState) {
              return list(state.attendance);
            } else if (state is ErrorGetAttendanceState) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 150,
                  child: Center(
                      child: Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
              );
            }

            return SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ],
    );
  }

  Widget list(List<AttendanceModel> attendanceList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: attendanceList.length,
      itemBuilder: (_, int index) {
        AttendanceModel attendance = attendanceList[index];

        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SelectedAttendancePageStudent(attendance)));
          },
          title: Text(attendance.sId),
          subtitle: Text(attendance.description),
          trailing: Column(
            children: [
              Text('Closing Date'),
              Text('${attendance.endDate}'),
            ],
          ),
        );
      },
    );
  }
}

class ClassInfoWidgetStudent extends StatelessWidget {
  final RegisteredClassId classModel;

  const ClassInfoWidgetStudent(this.classModel);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${classModel.className} Class',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      maxLines: 2,
                    ),
                    Text(
                      'Created at ${classModel.createdAt.substring(0, 10)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              Text(
                '${classModel.description}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Id',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: classModel.sId));

                  final snackBar = SnackBar(
                    content: Text('Copied to Clipboard'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  '${classModel.sId}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Status',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              Text(
                'Class Is Currently ${classModel.isOpened ? ' Opened' : ' Closed'}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDVkNDk3MjBjNzliNzAwMTU2OTFjN2UiLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTYxODE4MTc1M30.6_0jpdShvPssxlUjXleguhp9ntWguBZanTj3aJu7D0o
