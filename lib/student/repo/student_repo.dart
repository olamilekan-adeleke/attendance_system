import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:school_project/hive_methods/hive_class.dart';

class StudentRepo {
  final String _baseUrl = 'https://attendance-uil.herokuapp.com/api';

  Future<List> getClass() async {
    List data;
    String token = await HiveMethods().getUserToken();

    http.Response response = await http.get(
      '$_baseUrl/classes/student',
      headers: {"Content-Type": "application/json", 'Authorization': token},
    );

    print(response.body);

    if (jsonDecode(response.body) is Map) {
      return [];
    }

    data = jsonDecode(response.body);

    return data;
  }

  Future<Map<String, dynamic>> registerForAClass(
      {@required String classId}) async {
    Map<String, dynamic> data;
    String token = await HiveMethods().getUserToken();
    var body = {"class_id": classId};

    print(classId);

    http.Response response = await http.post(
      '$_baseUrl/classes/join',
      body: json.encode(body),
      headers: {"Content-Type": "application/json", 'Authorization': token},
    );

    print(response.body);
    data = jsonDecode(response.body);

    return data;
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

  Future<Map<String, dynamic>> signAttendance(String attendanceId) async {
    Dio _dio = Dio();
    Map<String, dynamic> data;
    String token = await HiveMethods().getUserToken();

    // _dio.options.headers = {'Authorization': token};

    print(attendanceId);

    LocationData locationData = await getLocation();
    print(locationData);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print(androidInfo.androidId);

    ScanResult barcode = await BarcodeScanner.scan();
    print('bar code:${barcode.rawContent} || code:$attendanceId');

    // if (barcode.rawContent.substring(0, barcode.rawContent.length - 1) !=
    //     attendanceId) {
    //   throw Exception('Wrong bar code');
    // }

    Map body = {
      'attendance_id': attendanceId,
      'phone_id': androidInfo.androidId,
      'location':
          "{ 'longitude': ${locationData.longitude}, 'latitude': ${locationData.latitude} }",
    };

    print('kkddk');

    print('response.data');
    print(attendanceId);
    print(body);

    http.Response response = await http.post(
      '$_baseUrl/attendance/sign',
      headers: {'Authorization': token, "Content-Type": "application/json"},
      body: json.encode(body),
    );

    // print(response.data);
    // print(response.data.runtimeType);
    print(jsonDecode(response.body));
    print(jsonDecode(response.body).runtimeType);
    print('response.data');

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // data = Map.from(response.data);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
      // throw Exception(Map.from(response.data)['message']);
    }

    return data;
  }
}
