class LastSendSms {
  Res? res;
  bool? status;

  LastSendSms({this.res, this.status});

  LastSendSms.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
    status = json['status'] ? json['status'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    } else {
      data['res'] = Res(
        iD: 0,
        phoneNumber: '',
        code: '',
        sentAt: '',
        verified: false,
      ).toJson();
    }
    data['status'] = status ?? false;
    return data;
  }

  @override
  String toString() {
    return 'LastSendSms{res: $res, status: $status}';
  }
}

class Res {
  int? iD;
  String? phoneNumber;
  String? code;
  String? sentAt;
  bool? verified;

  Res({this.iD, this.phoneNumber, this.code, this.sentAt, this.verified});

  Res.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? 0;
    phoneNumber = json['PhoneNumber'] ?? '';
    code = json['Code'] ?? '';
    sentAt = json['SentAt'] ?? '';
    verified = json['Verified'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD ?? 0;
    data['PhoneNumber'] = phoneNumber ?? '';
    data['Code'] = code ?? '';
    data['SentAt'] = sentAt ?? '';
    data['Verified'] = verified ?? false;
    return data;
  }

  @override
  String toString() {
    return 'Res{iD: $iD, phoneNumber: $phoneNumber, code: $code, sentAt: $sentAt, verified: $verified}';
  }
}
