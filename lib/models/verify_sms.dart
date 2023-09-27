class VerifySms {
  Res? res;
  bool? status;

  VerifySms({this.res, this.status});

  VerifySms.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
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

  @override
  String toString() {
    return 'VerifySms{res: $res, status: $status}';
  }
}

class Res {
  bool? register;
  String? token;
  var user;

  Res({this.register, this.token, this.user});

  Res.fromJson(Map<String, dynamic> json) {
    register = json['Register'];
    token = json['Token'];
    user = json['User'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Register'] = register;
    data['Token'] = token;
    data['User'] = user;
    return data;
  }

  @override
  String toString() {
    return 'Res{register: $register, token: $token, user: $user}';
  }
}
