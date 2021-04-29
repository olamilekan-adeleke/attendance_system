import 'package:dio/dio.dart';

import '../../auth/model/login_user_model.dart';
import '../../auth/model/register_user_model.dart';

class Authentication {
  static final String baseUrl = 'https://attendance-uil.herokuapp.com/api';
  Dio _dio = Dio();

  Future<Map> signUpUser(RegisterUserModel registerUser) async {
    Map data;

    try {
      print(registerUser.toMap().toString());

      Response response = await _dio.post(
        '$baseUrl/users/',
        data: registerUser.toMap(),
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        data = Map.from(response.data);
      } else {
        throw Exception(Map.from(response.data)['message']);
      }
    } on DioError catch (e, s) {
      print(e);
      print(s);
      throw Exception(e?.message.toString());
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception(e?.message.toString());
    }
    return data;
  }

  Future<Map> logInUser(LoginUserModel loginUser) async {
    Map data;

    try {
      Response response = await _dio.post(
        '$baseUrl/auth',
        data: loginUser.toMap(),
      );

      print(response.data);
      // print('response.data');

      if (response.statusCode == 200 || response.statusCode == 201) {
        data = Map.from(response.data);
      } else {
        throw Exception(Map.from(response.data));
      }
    } catch (e, s) {
      print(e);
      print(s);
      // print(Map.from(response.data));

      if (e is DioError) {
        //handle DioError here by error type or by error code
        throw Exception(e.message.toString());
      } else {
        throw Exception(e?.message.toString());
      }
    }
    return data;
  }
}
