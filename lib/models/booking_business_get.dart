class BookingBusinessGetList {
  List<BookingBusinessGetListRes>? res;
  bool? status;

  BookingBusinessGetList({this.res, this.status});

  BookingBusinessGetList.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <BookingBusinessGetListRes>[];
      json['res'].forEach((v) {
        res!.add(BookingBusinessGetListRes.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class BookingBusinessGetListRes {
  int? id;
  int? businessId;
  int? clientId;
  String? date;
  String? time;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? photoUrl;

  BookingBusinessGetListRes(
      {this.id,
        this.businessId,
        this.clientId,
        this.date,
        this.time,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.photoUrl});

  BookingBusinessGetListRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    clientId = json['client_id'];
    date = json['date'];
    time = json['time'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['client_id'] = clientId;
    data['date'] = date;
    data['time'] = time;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['photo_url'] = photoUrl;
    return data;
  }
}
