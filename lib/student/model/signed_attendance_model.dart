class SignedAttendanceModel {
  String message;
  Result result;

  SignedAttendanceModel({this.message, this.result});

  SignedAttendanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String sId;
  String attendanceId;
  String phoneId;
  String location;
  String userId;
  String createdAt;
  String distanceInMeters;
  String updatedAt;
  int iV;

  Result(
      {this.sId,
      this.attendanceId,
      this.phoneId,
      this.location,
      this.userId,
      this.distanceInMeters,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    attendanceId = json['attendance_id'];
    phoneId = json['phone_id'];
    location = json['location'];
    distanceInMeters = json['distance_in_meters'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['attendance_id'] = this.attendanceId;
    data['phone_id'] = this.phoneId;
    data['location'] = this.location;
    data['distance_in_meters'] = this.distanceInMeters;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
