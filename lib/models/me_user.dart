class MeUser {
  MeRes? res;
  bool? status;

  MeUser({this.res, this.status});

  MeUser.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? MeRes.fromJson(json['res']) : MeRes(
      fistName: '',
      lastName: '',
      userName: '',
      phoneNumber: '',
      address: '',
      photoUrl: '',
    );
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    }else{
      data['res'] = MeRes(
        fistName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        address: '',
        photoUrl: '',
      ).toJson();
    }
    data['status'] = status ?? false;
    return data;
  }
}

class MeRes {
  int? id;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;

  MeRes(
      {this.id,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl});

  MeRes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fistName = json['fist_name'] ?? '';
    lastName = json['last_name'] ?? '';
    userName = json['user_name'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    address = json['address'] ?? '';
    photoUrl = json['photo_url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['fist_name'] = fistName ?? '';
    data['last_name'] = lastName ?? '';
    data['user_name'] = userName ?? '';
    data['phone_number'] = phoneNumber ?? '';
    data['address'] = address ?? '';
    data['photo_url'] = photoUrl ?? '';
    return data;
  }
}