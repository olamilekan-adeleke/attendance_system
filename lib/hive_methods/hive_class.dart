import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_project/auth/model/login_user_model.dart';

import '../auth/methods/auth_methods.dart';
import '../auth/model/user_model.dart';

class HiveMethods {
  Future startUserHive() async {
    Directory documentDir = await getApplicationSupportDirectory();
    Hive.init(documentDir.path);
    await Hive.openBox<Map>('userDataBox');
  }

  Future<Box<Map>> getOpenBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  Future saveUserDetails(String email, String password) async {
    Box userBox = await getOpenBox('userDataBox');
    //
    try {
      Map data = await Authentication().logInUser(
        LoginUserModel(email: email, password: password),
      );
      await userBox.put('userData', data);
      print('save');
    } on HiveError catch (e) {
      throw Exception(e.message.toString());
    } catch (e) {
      throw Exception(e.message.toString());
    }
  }

  Future<String> userEmail() async {
    // Box data = Hive.box('userDataBox');
    Box data = await getOpenBox('userDataBox');

    return data.get('userData')['email'];
  }

  Future<UserModel> getUserDetails() async {
    Box userBox = await getOpenBox('userDataBox');
    UserModel userData;
    print(userBox.toMap());

    try {
      Map data = await userBox.get('userData');
      userData = UserModel.fromMap(data);
      print('save');
    } on HiveError catch (e) {
      throw Exception(e.message.toString());
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception(e.toString());
    }

    return userData;
  }

  Future<String> getUserToken() async {
    Box userBox = await getOpenBox('userDataBox');
    String userToken;
    print(userBox.toMap());

    try {
      Map data = await userBox.get('userData');
      userToken = data['token'];
      print(userToken);
    } on HiveError catch (e) {
      throw Exception(e.message.toString());
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception(e.toString());
    }

    return userToken;
  }
}
