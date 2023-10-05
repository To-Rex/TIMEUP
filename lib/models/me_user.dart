class MeUser {
  MeRes? res;
  bool? status;

  MeUser({this.res, this.status});

  MeUser.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? MeRes.fromJson(json['res']) : null;
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

class MeRes {
  int? id;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;
  Business? business;

  MeRes(
      {this.id,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl,
        this.business});

  MeRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    photoUrl = json['photo_url'];
    business = json['business'] != null
        ? Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['photo_url'] = photoUrl;
    if (business != null) {
      data['business'] = business!.toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  int? userId;
  int? workCategoryId;
  String? officeAddress;
  String? officeName;
  int? experience;
  String? bio;
  String? dayOffs;

  Business(
      {this.id,
        this.userId,
        this.workCategoryId,
        this.officeAddress,
        this.officeName,
        this.experience,
        this.bio,
        this.dayOffs});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    workCategoryId = json['work_category_id'];
    officeAddress = json['office_address'];
    officeName = json['office_name'];
    experience = json['experience'];
    bio = json['bio'];
    dayOffs = json['day_offs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['work_category_id'] = workCategoryId;
    data['office_address'] = officeAddress;
    data['office_name'] = officeName;
    data['experience'] = experience;
    data['bio'] = bio;
    data['day_offs'] = dayOffs;
    return data;
  }
}
