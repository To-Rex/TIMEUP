class Register {
  Res? res;
  bool? status;

  Register({this.res, this.status});

  Register.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null
        ? Res.fromJson(json['res'])
        : Res(
            user: User(
                id: 0,
                fistName: '',
                lastName: '',
                userName: '',
                phoneNumber: '',
                address: '',
                photoUrl: ''),
            token: '');
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    }else{
      data['res'] = Res(
          user: User(
              id: 0,
              fistName: '',
              lastName: '',
              userName: '',
              phoneNumber: '',
              address: '',
              photoUrl: ''),
          token: '');
    }
    data['status'] = status ?? false;
    return data;
  }
}

class Res {
  User? user;
  String? token;

  Res({this.user, this.token});

  Res.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : User(
        id: 0,
        fistName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        address: '',
        photoUrl: ''
    );
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }else{
      data['user'] = User(
          id: 0,
          fistName: '',
          lastName: '',
          userName: '',
          phoneNumber: '',
          address: '',
          photoUrl: ''
      );
    }
    data['token'] = token ?? '';
    return data;
  }
}

class User {
  int? id;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;

  User(
      {this.id,
      this.fistName,
      this.lastName,
      this.userName,
      this.phoneNumber,
      this.address,
      this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
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
