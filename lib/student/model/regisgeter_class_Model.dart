class RegisteredClassModel {
  String sId;
  RegisteredClassId classId;
  String student;
  String createdAt;
  String updatedAt;
  int iV;

  RegisteredClassModel(
      {this.sId,
      this.classId,
      this.student,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RegisteredClassModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    classId = json['class_id'] != null
        ? new RegisteredClassId.fromJson(json['class_id'])
        : null;
    student = json['student'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.classId != null) {
      data['class_id'] = this.classId.toJson();
    }
    data['student'] = this.student;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class RegisteredClassId {
  bool isOpened;
  String sId;
  String className;
  String description;
  String instructorId;
  String createdAt;
  String updatedAt;
  int iV;

  RegisteredClassId(
      {this.isOpened,
      this.sId,
      this.className,
      this.description,
      this.instructorId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RegisteredClassId.fromJson(Map<String, dynamic> json) {
    isOpened = json['isOpened'];
    sId = json['_id'];
    className = json['class_name'];
    description = json['description'];
    instructorId = json['instructor_id'];
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
    data['instructor_id'] = this.instructorId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
