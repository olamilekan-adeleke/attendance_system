import 'package:flutter/material.dart';
import 'package:school_project/instructor/pages/instructor_home_page.dart';
import 'package:school_project/student/pages/student_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.role);

  final String role;
  @override
  Widget build(BuildContext context) {
    if(role == 'student') {
      return StudentHomePage();
    }else{
      return InstructorHomePage();
    }
  }
}
