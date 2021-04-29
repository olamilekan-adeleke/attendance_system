import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/instructor/bloc/create_class_bloc.dart';

class CreateNewClassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
        body: CreateNewClassFormWidget(),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text('Create Class'),
      centerTitle: true,
    );
  }
}

class CreateNewClassFormWidget extends StatefulWidget {
  @override
  _CreateNewClassFormWidgetState createState() =>
      _CreateNewClassFormWidgetState();
}

class _CreateNewClassFormWidgetState extends State<CreateNewClassFormWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

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
              CircleAvatar(radius: 55),
              SizedBox(height: 20),
              emailInputFieldBox(
                  controller: nameController, title: 'Class Name'),
              SizedBox(height: 10),
              emailInputFieldBox(
                  controller: descriptionController, title: 'description'),
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
          if (nameController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty) {
            BlocProvider.of<CreateClassBloc>(context).add(CreateNewClassEvent(
              className: nameController.text.trim(),
              des: descriptionController.text.trim(),
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
    return BlocConsumer<CreateClassBloc, CreateClassState>(
      listener: (context, state) {
        if (state is ErrorCreateClassState) {
          return showPopUp(context: context, body: state.message);
        } else if (state is LoadedCreateClassState) {
          showPopUp(context: context, body: state.data['message']);
          nameController.clear();
          descriptionController.clear();
        }
      },
      builder: (context, state) {
        if (state is LoadingCreateClassState) {
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
