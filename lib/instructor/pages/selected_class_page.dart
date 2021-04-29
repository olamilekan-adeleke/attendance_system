import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/get_attendance_bloc/get_attendance_bloc.dart';
import 'package:school_project/instructor/model/attendance_model.dart';
import 'package:school_project/instructor/model/class_model.dart';
import 'package:school_project/instructor/pages/create_attendance_page.dart';
import 'package:school_project/instructor/pages/user_that_sign_attendance_teacher.dart';

class SelectedClassPageInstructor extends StatelessWidget {
  const SelectedClassPageInstructor(this.classModel);

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ClassInfoWidget(classModel),
          AttendanceListWidget(classModel.sId),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateAttendancePage(classModel.sId),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AttendanceListWidget extends StatefulWidget {
  const AttendanceListWidget(this.classId);

  final String classId;

  @override
  _AttendanceListWidgetState createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends State<AttendanceListWidget> {
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
              return SizedBox(
                height: 150,
                child: Center(child: Text(state.message)),
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
                    SelectedAttendancePageTeacher(attendance)));
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

class ClassInfoWidget extends StatelessWidget {
  final ClassModel classModel;

  const ClassInfoWidget(this.classModel);

  @override
  Widget build(BuildContext context) {
    print(classModel.toJson());
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
                'Instructor Details',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    '${classModel.instructorId.title} ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                  Text(
                    '${classModel.instructorId.firstname} ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                  Text(
                    '${classModel.instructorId.lastname}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                ],
              ),
              Text(
                '${classModel.instructorId.email} ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                maxLines: 1,
              ),
              Text(
                '${classModel.instructorId.phone} ',
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
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDczODk4YmEwZDdmMzAwMTU4MjlhOGUiLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTYxODE4NDU4OH0.w9nKtw41YZYpjmzCAmBzg4tYfB9l-kvJDTWfV7SwkwE

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDVkM2FkYjBmM2ZiMjAwMTVjMmI0ODMiLCJyb2xlIjoiaW5zdHJ1Y3RvciIsImlhdCI6MTYxODE4NTA0M30.83XLMxjdn-kgUh8i_lB6d92_T2nA-GUez0JTAFQ7mkU
