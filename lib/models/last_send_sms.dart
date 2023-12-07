class LastSendSms {
  LastSendSmsRes? res;
  bool? status;

  LastSendSms({this.res, this.status});

  LastSendSms.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? LastSendSmsRes.fromJson(json['res']) : null;
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

class LastSendSmsRes {
  int? iD;
  String? phoneNumber;
  String? code;
  String? sentAt;
  bool? verified;

  LastSendSmsRes({this.iD, this.phoneNumber, this.code, this.sentAt, this.verified});

  LastSendSmsRes.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    phoneNumber = json['PhoneNumber'];
    code = json['Code'];
    sentAt = json['SentAt'];
    verified = json['Verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['PhoneNumber'] = phoneNumber;
    data['Code'] = code;
    data['SentAt'] = sentAt;
    data['Verified'] = verified;
    return data;
  }
}
