import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/update_attendance_bloc/update_attendance_bloc.dart';
import 'package:school_project/instructor/model/attendance_model.dart';
import 'package:school_project/instructor/model/user_that_sign.dart';
import 'package:school_project/instructor/pages/qr_code_widget.dart';

class SelectedAttendancePageTeacher extends StatelessWidget {
  final AttendanceModel attendance;

  const SelectedAttendancePageTeacher(this.attendance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AttendanceInfoWidgetTeacher(attendance),
          UserSignAttendanceListWidgetTeacher(attendance.sId),
        ],
      ),
    );
  }
}

class AttendanceInfoWidgetTeacher extends StatelessWidget {
  const AttendanceInfoWidgetTeacher(this.attendance);

  final AttendanceModel attendance;
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
                      '${attendance.sId} Attendance',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      maxLines: 2,
                    ),
                    Text(
                      'Created at ${attendance.createdAt.substring(0, 10)}',
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
                '${attendance.description}',
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
                'Attendance Id',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: attendance.sId));

                  final snackBar = SnackBar(
                    content: Text('Copied to Clipboard'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  '${attendance.sId}',
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
                'Attendance Status',
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              Text(
                'Attendance Is Currently ${attendance.isOpened ? ' Opened' : ' Closed'}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlatButton(
                onPressed: () {
                  print(attendance.qr_code);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QrCodeWidget(attendance.qr_code)));
                },
                child: Text('Bar Code', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Spacer(),
        //       BlocConsumer<UpdateAttendanceBloc, UpdateAttendanceState>(
        //         listener: (context, state) {
        //           if (state is ErrorSignAttendanceState) {
        //             final snackBar = SnackBar(
        //               content: Text(
        //                 'Error: ${state.message}',
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //               backgroundColor: Colors.red,
        //             );
        //
        //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //           } else if (state is LoadedSignAttendanceState) {
        //             final snackBar = SnackBar(
        //               content: Text(
        //                 '${state.data['message']}',
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //               backgroundColor: Colors.green,
        //             );
        //
        //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //             BlocProvider.of<UpdateAttendanceBloc>(context)
        //                 .add(FetchAttendanceEvent(attendance.sId));
        //           }
        //         },
        //         builder: (context, state) {
        //           if (state is LoadingSignAttendanceState) {
        //             return CircularProgressIndicator();
        //           }
        //           return FlatButton(
        //             color: Colors.blue,
        //             onPressed: () =>
        //                 BlocProvider.of<UpdateAttendanceBloc>(context)
        //                     .add(SignAttendanceEvent(attendance.sId)),
        //             child: Text(
        //               'Sign',
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class UserSignAttendanceListWidgetTeacher extends StatefulWidget {
  const UserSignAttendanceListWidgetTeacher(this.attendanceId);

  final String attendanceId;

  @override
  _UserSignAttendanceListWidgetTeacherState createState() =>
      _UserSignAttendanceListWidgetTeacherState();
}

class _UserSignAttendanceListWidgetTeacherState
    extends State<UserSignAttendanceListWidgetTeacher> {
  @override
  void initState() {
    BlocProvider.of<UpdateAttendanceBloc>(context)
        .add(FetchAttendanceEvent(widget.attendanceId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Text('Users That Have Sign Attendance'),
        Divider(),
        BlocConsumer<UpdateAttendanceBloc, UpdateAttendanceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedFetchAttendanceState) {
              return list(state.users);
            } else if (state is ErrorFetchAttendanceState) {
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
            } else if (state is LoadingFetchAttendanceState) {
              return SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  Widget list(UserThatSignAttendanceModel usersList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: usersList.attendance.length,
      itemBuilder: (_, int index) {
        Attendance user = usersList.attendance[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {},
              title: Text('${user.userId.firstname} ${user.userId.lastname}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone: ${user.userId.phone}'),
                  Text('Email: ${user.userId.email}'),
                  Text('Reg Number: ${user.userId.regNo}'),
                  Text('Distance: ${user.distance ?? 0} Meters'),
                  Text('Sign At: ${user.createdAt}'),
                ],
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
