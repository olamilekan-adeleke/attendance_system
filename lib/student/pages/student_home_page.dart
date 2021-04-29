import 'package:flutter/material.dart';
import 'package:school_project/auth/page/login_page.dart';
import 'package:school_project/student/widgets/register_class_form.dart';
import 'package:school_project/student/widgets/student_home_widget.dart';

class StudentHomePage extends StatelessWidget {
  void showBottomModal(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('Register For Class'),
          content: RegisterNewClassPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ToggleBetweenLoginAndSignUpPage()));
            },
          ),
        ],
      ),
      body: StudentHomeWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
