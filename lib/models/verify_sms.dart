class VerifySms {
  Resurs? res;
  bool? status;

  VerifySms({this.res, this.status});

  VerifySms.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Resurs.fromJson(json['res']) : null;
    status = json['status'] ? json['status'] : false;
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

class Resurs {
  bool? register;
  String? token;

  Resurs({this.register, this.token});

  Resurs.fromJson(Map<String, dynamic> json) {
    register = json['Register'] ?? false;
    token = json['Token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Register'] = register;
    data['Token'] = token;
    return data;
  }

  @override
  String toString() {
    return 'Resurs{register: $register, token: $token}';
  }
}
