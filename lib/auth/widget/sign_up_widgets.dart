import 'package:flutter/material.dart';
import 'package:school_project/auth/methods/auth_methods.dart';
import 'package:school_project/auth/widget/customTextFeild.dart';
import 'package:school_project/auth/widget/custom_drop_down.dart';
import 'package:school_project/hive_methods/hive_class.dart';
import 'package:school_project/home/pages/home_page.dart';

import '../../auth/model/register_user_model.dart';

class SignUpInHeader extends StatelessWidget {
  final Size size;

  const SignUpInHeader({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: size.height * 0.07),
      width: size.width,
      height: size.height * 0.22,
      child: Text(
        'Let\'s Start!',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SignUpBody extends StatefulWidget {
  final Size size;
  final Function toggleView;

  const SignUpBody({this.size, this.toggleView});

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final formKey = GlobalKey<FormState>();

  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  ValueNotifier<String> title = ValueNotifier(null);
  ValueNotifier<String> gender = ValueNotifier(null);
  ValueNotifier<String> role = ValueNotifier(null);

  RegisterUserModel registerUser;

  Future<void> validateForm() async {
    final formState = formKey.currentState;

    if (formState.validate() &&
        role.value != null &&
        title.value != null &&
        gender.value != null) {
      // print('pass');

      registerUser = RegisterUserModel(
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        title: title.value.toLowerCase(),
        dob: dobController.text.trim(),
        gender: gender.value.toLowerCase(),
        picture: '...',
        regNo: regNoController.text.trim(),
        role: role.value.toLowerCase(),
      );

      valueNotifier.value = true;
      //
      try {
        Map data = await Authentication().signUpUser(registerUser);
        await HiveMethods().saveUserDetails(
          registerUser.email,
          registerUser.password,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(data['data']['role']),
          ),
        );

        _showDialog(data['message']);
      } catch (e, s) {
        print(e);
        print(s);
        _showDialog(e.toString());
      }

      valueNotifier.value = false;
    }
  }

  void _showDialog(String body) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      width: widget.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: form(context),
    );
  }

  Widget form(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: widget.size.height * 0.05),
            CustomTextField(
              controller: firstNameController,
              textFieldTitle: 'First name',
              textLength: 3,
            ),
            SizedBox(height: widget.size.height * 0.03),
            CustomTextField(
              controller: lastNameController,
              textFieldTitle: 'Last name',
              textLength: 3,
            ),
            SizedBox(height: widget.size.height * 0.03),
            CustomTextField(
              controller: emailController,
              textFieldTitle: 'Email Address',
            ),
            SizedBox(height: widget.size.height * 0.03),
            CustomTextField(
              controller: phoneController,
              textFieldTitle: 'Phone Number',
              textLength: 10,
            ),
            SizedBox(height: widget.size.height * 0.03),
            titleAndGenderDropDown(),
            CustomTextField(
              controller: regNoController,
              textFieldTitle: 'Reg Number',
              textLength: 9,
            ),
            SizedBox(height: widget.size.height * 0.03),
            roleAndDobDropDown(),
            CustomTextField(
              controller: passwordController,
              textFieldTitle: 'Password',
              textLength: 5,
              hideText: true,
            ),
            SizedBox(height: widget.size.height * 0.025),
            signUpButton(),
            SizedBox(height: widget.size.height * 0.03),
            moreOptions(),
            SizedBox(height: widget.size.height * 0.08),
          ],
        ),
      ),
    );
  }

  Widget titleAndGenderDropDown() {
    return Row(
      children: [
        Expanded(
          child: CustomDropDown(
            dropDownList: ['Mr', 'Mrs'],
            dropDownValue: title,
            title: 'Title',
          ),
        ),
        Expanded(
          child: CustomDropDown(
            dropDownList: ['M', 'F'],
            dropDownValue: gender,
            title: 'Gender',
          ),
        ),
      ],
    );
  }

  Widget roleAndDobDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomDropDown(
            dropDownList: ['Student', 'Instructor'],
            dropDownValue: role,
            title: 'Role',
          ),
        ),
        Expanded(
          child: CustomTextField(
            controller: dobController,
            textFieldTitle: 'Year Of Birth (eg 2002)',
            textLength: 3,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget signUpButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, bool value, child) {
        // print(value);
        if (value == true) {
          return Center(child: CircularProgressIndicator());
        }

        return InkWell(
          onTap: () => validateForm(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget moreOptions() {
    return Container(
      width: widget.size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () => widget.toggleView(),
              child: Text(
                'Already Sign Up? Login',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
