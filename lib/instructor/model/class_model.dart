class ClassModel {
  bool isOpened;
  String sId;
  String className;
  String description;
  InstructorId instructorId;
  String createdAt;
  String updatedAt;
  int iV;

  ClassModel(
      {this.isOpened,
      this.sId,
      this.className,
      this.description,
      this.instructorId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ClassModel.fromJson(Map<String, dynamic> json) {
    isOpened = json['isOpened'];
    sId = json['_id'];
    className = json['class_name'];
    description = json['description'];
    instructorId = json['instructor_id'] != null
        ? new InstructorId.fromJson(json['instructor_id'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOpened'] = this.isOpened;
    data['_id'] = this.sId;
    data['class_name'] = this.className;
    data['description'] = this.description;
    if (this.instructorId != null) {
      data['instructor_id'] = this.instructorId.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class InstructorId {
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

  InstructorId(
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

  InstructorId.fromJson(Map<String, dynamic> json) {
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
