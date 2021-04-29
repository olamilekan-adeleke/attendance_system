import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:school_project/hive_methods/hive_class.dart';
import 'package:school_project/instructor/model/attendance_model.dart';
import 'package:school_project/instructor/model/user_that_sign.dart';

class InstructorRepo {
  final String _baseUrl = 'https://attendance-uil.herokuapp.com/api';
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> createClass({
    @required String className,
    @required String description,
  }) async {
    Map<String, dynamic> data;
    String token = await HiveMethods().getUserToken();
    var body = {"class_name": className, "description": description};

    print(className);
    print(description);

    http.Response response = await http.post(
      '$_baseUrl/classes',
      body: json.encode(body),
      headers: {"Content-Type": "application/json", 'Authorization': token},
    );

    print(response.body);
    data = jsonDecode(response.body);

    return data;
  }

  Future<List<Map<String, dynamic>>> getAllClass() async {
    List<Map<String, dynamic>> data;
    String token = await HiveMethods().getUserToken();

    http.Response response = await http.get(
      '$_baseUrl/classes/instructor',
      headers: {'Authorization': token},
    );

    print(response.body);
    print(response.body.runtimeType);
    print(jsonDecode(response.body).runtimeType);

    if (jsonDecode(response.body) is Map) {
      return [];
    }

    List classes = jsonDecode(response.body);
    data = classes.map((e) => Map<String, dynamic>.from(e)).toList();

    return data;
  }

  Future<List<AttendanceModel>> getAllAttendance(String classId) async {
    List<AttendanceModel> attendance = <AttendanceModel>[];
    String token = await HiveMethods().getUserToken();

    http.Response response = await http.get(
      '$_baseUrl/attendance/class/$classId',
      headers: {'Authorization': token},
    );

    print(response.body);
    print(response.body.runtimeType);
    print(jsonDecode(response.body).runtimeType);

    if (jsonDecode(response.body) is List) {
      List attendanceList = jsonDecode(response.body);

      attendance =
          attendanceList.map((e) => AttendanceModel.fromJson(e)).toList();
    } else if (jsonDecode(response.body) is Map) {
      throw Exception(jsonDecode(response.body)['message']);
    }

    return attendance;
  }

  Future<Map<String, dynamic>> createAttendance({
    @required String className,
    @required String description,
    @required String endDate,
  }) async {
    Map<String, dynamic> data;
    String token = await HiveMethods().getUserToken();

    _dio.options.headers = {'Authorization': token};

    LocationData locationData = await getLocation();

    Response response = await _dio.post(
      '$_baseUrl/attendance',
      data: {
        "class_id": className,
        "description": description,
        "end_date": endDate,
        "location":
            "{ 'longitude': ${locationData.longitude}, 'latitude': ${locationData.latitude} }",
      },
    );

    print(response.data);
    print(response.data.runtimeType);
    // print(jsonDecode(response.data).runtimeType);

    if (response.statusCode == 200) {
      data = Map.from(response.data);
    }

    return data;
  }

  Future<UserThatSignAttendanceModel> fetchAllUserSignAttendance(
      String attendanceId) async {
    UserThatSignAttendanceModel users;
    String token = await HiveMethods().getUserToken();

    // _dio.options.headers = {'Authorization': token};

    print(attendanceId);

    http.Response response = await http.get(
      '$_baseUrl/attendance/users/all/$attendanceId',
      // queryParameters: {"attendance_id": attendanceId},
    );

    print(response.body);
    print(response.body.runtimeType);

    if (response.statusCode == 200) {
      Map<String, dynamic> dataList = jsonDecode(response.body);

      if (List.from(dataList['attendance']).isEmpty) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      users = UserThatSignAttendanceModel.fromJson(
          dataList.cast<String, dynamic>());
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
    //
    return users;
  }

  Future<LocationData> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return _locationData;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return _locationData;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}
