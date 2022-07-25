class Doctor {
  bool enabled;
  String id;
  String name;
  String email;
  String department;
  int phone;
  String password;
  int type;
  String designation;
  DateTime doj;
  String education;
  String aboutMe;
  String registrationNo;
  String gender;
  String profilePic;
  int v;

  Doctor(
      {this.enabled,
      this.id,
      this.name,
      this.email,
      this.department,
      this.phone,
      this.password,
      this.type,
      this.designation,
      this.doj,
      this.education,
      this.aboutMe,
      this.registrationNo,
      this.gender,
      this.profilePic,
      this.v});

  Doctor.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    department = json['department'];
    phone = json['phone'];
    password = json['password'];
    type = json['type'];
    designation = json['designation'];
    doj = DateTime.parse(json['doj']);
    education = json['education'];
    aboutMe = json['about_me'];
    registrationNo = json['registration_no'];
    gender = json['gender'];
    profilePic = json['profile_pic'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['department'] = this.department;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['type'] = this.type;
    data['designation'] = this.designation;
    data['doj'] = this.doj.toString();
    data['education'] = this.education;
    data['about_me'] = this.aboutMe;
    data['registration_no'] = this.registrationNo;
    data['gender'] = this.gender;
    data['profile_pic'] = this.profilePic;
    data['__v'] = this.v;
    return data;
  }
}
