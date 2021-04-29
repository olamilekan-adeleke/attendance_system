import 'package:flutter/material.dart';
import 'package:school_project/auth/page/login_page.dart';
import 'package:school_project/instructor/pages/create_new_class_page.dart';
import 'package:school_project/instructor/widget/all_classes_widget.dart';

class InstructorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(context),
        body: AllClassesWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNewClassPage())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  AppBar _appbar(context) {
    return AppBar(
      title: Text('All Classes'),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app_outlined),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ToggleBetweenLoginAndSignUpPage()));
          },
        ),
      ],
    );
  }
}
