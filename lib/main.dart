import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/bloc_list.dart';
import 'package:school_project/hive_methods/hive_class.dart';
// import 'package:school_project/home/pages/home_page.dart';

import 'auth/page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveMethods().startUserHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocLis(context),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ToggleBetweenLoginAndSignUpPage(),
        // home: HomePage(),
      ),
    );
  }
}
