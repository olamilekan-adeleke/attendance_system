class RegisterUserModel {
  String firstname;
  String lastname;
  String email;
  String title;
  String gender;
  String password;
  String phone;
  String dob;
  String picture;
  String role;
  String regNo;

  RegisterUserModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.title,
      this.gender,
      this.password,
      this.phone,
      this.dob,
      this.picture,
      this.role,
      this.regNo});

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    firstname = json["firstname"];
    lastname = json["lastname"];
    email = json["email"];
    title = json["title"];
    gender = json["gender"];
    password = json["password"];
    phone = json["phone"];
    dob = json["dob"];
    picture = json["picture"];
    role = json["role"];
    regNo = json["regNo"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["firstname"] = this.firstname;
    data["lastname"] = this.lastname;
    data["email"] = this.email;
    data["title"] = this.title;
    data["gender"] = this.gender;
    data["password"] = this.password;
    data["phone"] = this.phone;
    data["dob"] = this.dob;
    data["picture"] = this.picture;
    data["role"] = this.role;
    data["regNo"] = this.regNo;
    return data;
  }
}
