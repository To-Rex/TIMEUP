class SendSms {
  var res;
  bool? status;

  SendSms({this.res, this.status});

  SendSms.fromJson(Map<String, dynamic> json) {
    res = json['res'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['res'] = res;
    data['status'] = status;
    return data;
  }

  @override
  String toString() {
    return 'SendSms{res: $res, status: $status}';
  }
}
