class UserThatSignAttendanceModel {
  String message;
  List<Attendance> attendance;

  UserThatSignAttendanceModel({this.message, this.attendance});

  UserThatSignAttendanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['attendance'] != null) {
      attendance = new List<Attendance>();
      json['attendance'].forEach((v) {
        attendance.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.attendance != null) {
      data['attendance'] = this.attendance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String sId;
  String attendanceId;
  String phoneId;
  String location;
  UserId userId;
  String createdAt;
  int distance;
  String updatedAt;
  int iV;

  Attendance(
      {this.sId,
      this.attendanceId,
      this.phoneId,
      this.location,
      this.distance,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Attendance.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    attendanceId = json['attendance_id'];
    phoneId = json['phone_id'];
    location = json['location'];
    distance = json['distance_in_m'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
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
    data['distance_in_m'] = this.distance;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserId {
  String picture;
  String resetToken;
  String sId;
  String firstname;
  String lastname;
  String email;
  String title;
  String gender;
  String password;
  String phone;
  String dob;
  String role;
  String regNo;
  String createdAt;
  String updatedAt;
  int iV;

  UserId(
      {this.picture,
      this.resetToken,
      this.sId,
      this.firstname,
      this.lastname,
      this.email,
      this.title,
      this.gender,
      this.password,
      this.phone,
      this.dob,
      this.role,
      this.regNo,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserId.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    resetToken = json['reset_token'];
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    title = json['title'];
    gender = json['gender'];
    password = json['password'];
    phone = json['phone'];
    dob = json['dob'];
    role = json['role'];
    regNo = json['regNo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picture'] = this.picture;
    data['reset_token'] = this.resetToken;
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['title'] = this.title;
    data['gender'] = this.gender;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['role'] = this.role;
    data['regNo'] = this.regNo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
