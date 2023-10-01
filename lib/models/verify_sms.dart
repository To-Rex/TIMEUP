class VerifySms {
  Resurse? res;
  bool? status;

  VerifySms({this.res, this.status});

  VerifySms.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Resurse.fromJson(json['res']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Resurse {
  bool? register;
  String? token;
  VerifyUser? user;

  Resurse({this.register, this.token, this.user});

  Resurse.fromJson(Map<String, dynamic> json) {
    register = json['register'];
    token = json['token'];
    user = json['user'] != null ? VerifyUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['register'] = register;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class VerifyUser {
  int? iD;
  String? fistName;
  String? lastName;
  String? password;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;

  VerifyUser(
      {this.iD,
        this.fistName,
        this.lastName,
        this.password,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl});

  VerifyUser.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fistName = json['FistName'];
    lastName = json['LastName'];
    password = json['Password'];
    userName = json['VerifyUserName'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    photoUrl = json['PhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['FistName'] = fistName;
    data['LastName'] = lastName;
    data['Password'] = password;
    data['VerifyUserName'] = userName;
    data['PhoneNumber'] = phoneNumber;
    data['Address'] = address;
    data['PhotoUrl'] = photoUrl;
    return data;
  }
}
