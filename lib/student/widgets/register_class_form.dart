import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/student/bloc/get_all_registered_class_bloc/all_registered_class_bloc.dart';
import 'package:school_project/student/bloc/registered_class_bloc/register_class_bloc.dart';

class RegisterNewClassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterNewClassFormWidget();
  }
}

class RegisterNewClassFormWidget extends StatefulWidget {
  @override
  _RegisterNewClassFormWidgetState createState() =>
      _RegisterNewClassFormWidgetState();
}

class _RegisterNewClassFormWidgetState
    extends State<RegisterNewClassFormWidget> {
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          // shrinkWrap: true,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            emailInputFieldBox(controller: nameController, title: 'Class Id'),
            SizedBox(height: 40),
            bloc(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
      child: ElevatedButton(
        onPressed: () {
          if (nameController.text.isNotEmpty) {
            BlocProvider.of<RegisterClassBloc>(context)
                .add(RegisterForAClassEvent(
              nameController.text.trim(),
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
        ),
      ),
    );
  }

  Widget bloc() {
    return BlocConsumer<RegisterClassBloc, RegisterClassState>(
      listener: (context, state) {
        if (state is ErrorRegisterClassState) {
          return showPopUp(context: context, body: state.message);
        } else if (state is LoadedRegisterClassState) {
          showPopUp(context: context, body: state.data['message']);
          nameController.clear();
        }
      },
      builder: (context, state) {
        if (state is LoadingRegisterClassState) {
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
              Navigator.pop(context);
              BlocProvider.of<AllRegisteredClassBloc>(context)
                  .add(FetchAllRegisteredClassEvent());
            },
          ),
        ],
      );
    },
  );
}
