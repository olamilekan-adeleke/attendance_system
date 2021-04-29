class AttendanceModel {
  bool isOpened;
  String sId;
  String endDate;
  ClassId classId;
  String description;
  String createdAt;
  String updatedAt;
  int iV;
  String qr_code;

  AttendanceModel(
      {this.isOpened,
      this.sId,
      this.endDate,
      this.classId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.qr_code,
      this.iV});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    isOpened = json['isOpened'];
    sId = json['_id'];
    endDate = json['end_date'];
    classId = json['class_id'] != null
        ? new ClassId.fromJson(json['class_id'])
        : null;
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    qr_code = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOpened'] = this.isOpened;
    data['_id'] = this.sId;
    data['end_date'] = this.endDate;
    if (this.classId != null) {
      data['class_id'] = this.classId.toJson();
    }
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['qr_code'] = this.qr_code;
    data['__v'] = this.iV;
    return data;
  }
}

class ClassId {
  bool isOpened;
  String sId;
  String className;
  String description;
  String instructorId;
  String createdAt;
  String updatedAt;
  int iV;

  ClassId(
      {this.isOpened,
      this.sId,
      this.className,
      this.description,
      this.instructorId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ClassId.fromJson(Map<String, dynamic> json) {
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
