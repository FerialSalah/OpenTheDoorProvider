class User {
  bool status;
  Providerinfo providerinfo;

  User({
    this.status,
    this.providerinfo,
  });

  factory User.fromApi(Map<String, dynamic> json) => User(
        status: json["status"],
        providerinfo: Providerinfo.fromApi(json["providerinfo"]),
      );
}

class Providerinfo {
  int id;
  String name;
  dynamic email;
  String phone;
  String gender;
  String citizen;
  String employee;
  dynamic residentnumberorstatuscard;
  dynamic placeofemployment;
  String birthdate;
  dynamic userImage;
  dynamic fileRequier;
  String active;
  String apiToken;
  dynamic invitationCode;

  Providerinfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.citizen,
    this.employee,
    this.residentnumberorstatuscard,
    this.placeofemployment,
    this.birthdate,
    this.userImage,
    this.fileRequier,
    this.active,
    this.apiToken,
    this.invitationCode,
  });

  factory Providerinfo.fromApi(Map<String, dynamic> json) => Providerinfo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        citizen: json["citizen"],
        employee: json["employee"],
        residentnumberorstatuscard: json["residentnumberorstatuscard"],
        placeofemployment: json["placeofemployment"],
        birthdate: json["birthdate"],
        userImage: json["user_image"],
        fileRequier: json["file_requier"],
        active: json["active"],
        apiToken: json["api_token"],
        invitationCode: json["invitation_code"],
      );
}
