import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/create_attendance/create_attendence_bloc.dart';
import 'package:school_project/instructor/bloc/get_attendance_bloc/get_attendance_bloc.dart';

class CreateAttendancePage extends StatelessWidget {
  final String classId;

  const CreateAttendancePage(this.classId);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
        body: CreateAttendanceFormWidget(classId),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text('Create Attendance'),
      centerTitle: true,
    );
  }
}

class CreateAttendanceFormWidget extends StatefulWidget {
  const CreateAttendanceFormWidget(this.classId);

  final String classId;
  @override
  _CreateAttendanceFormWidgetState createState() =>
      _CreateAttendanceFormWidgetState();
}

class _CreateAttendanceFormWidgetState
    extends State<CreateAttendanceFormWidget> {
  TextEditingController classIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController closedDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // final ValueNotifier<DateTime> closedDate =
  //     ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    classIdController.text = widget.classId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              emailInputFieldBox(
                  controller: classIdController, title: 'Class Id  '),
              SizedBox(height: 10),
              emailInputFieldBox(
                  controller: descriptionController, title: 'description'),
              SizedBox(height: 10),
              emailInputFieldBox(
                controller: closedDateController,
                title: 'Closed Date',
                hintText: 'yyyy-mm-dd',
              ),
              SizedBox(height: 40),
              bloc(),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
      child: ElevatedButton(
        onPressed: () {
          if (classIdController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty &&
              closedDateController.text.isNotEmpty) {
            BlocProvider.of<CreateAttendanceBloc>(context)
                .add(MakeAttendanceEvent(
              className: classIdController.text.trim(),
              description: descriptionController.text.trim(),
              endDate: closedDateController.text.trim(),
            ));
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget emailInputFieldBox({
    @required TextEditingController controller,
    @required String title,
    String hintText,
  }) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.trim().isEmpty) {
            return '$title Can\'t Be Empty';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: "$title",
          hintText: hintText,
        ),
      ),
    );
  }

  Widget bloc() {
    return BlocConsumer<CreateAttendanceBloc, CreateAttendanceState>(
      listener: (context, state) {
        if (state is ErrorCreateAttendanceState) {
          return showPopUp(context: context, body: state.message);
        } else if (state is LoadedCreateAttendanceState) {
          showPopUp(context: context, body: state.data['message']);
          BlocProvider.of<GetAttendanceBloc>(context)
              .add(FetchAllAttendanceEvent(classIdController.text.trim()));
          classIdController.clear();
          descriptionController.clear();
          closedDateController.clear();
        }
      },
      builder: (context, state) {
        if (state is LoadingCreateAttendanceState) {
          return Center(child: CircularProgressIndicator());
        }

        return button();
      },
    );
  }
}

void showPopUp({@required BuildContext context, String body}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(child: Text('Message')),
        content: Text(
          '$body',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      );
    },
  );
}
