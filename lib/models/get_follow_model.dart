class GetFollowModel {
  List<GetFollowModelRes>? res;
  bool? status;

  GetFollowModel({this.res, this.status});

  GetFollowModel.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <GetFollowModelRes>[];
      json['res'].forEach((v) {
        res!.add(GetFollowModelRes.fromJson(v));
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

class GetFollowModelRes {
  int? id;
  String? categoryName;
  String? officeAddress;
  String? officeName;
  String? bio;
  String? dayOffs;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? photoUrl;

  GetFollowModelRes(
      {this.id,
      this.categoryName,
      this.officeAddress,
      this.officeName,
      this.bio,
      this.dayOffs,
      this.fistName,
      this.lastName,
      this.userName,
      this.phoneNumber,
      this.photoUrl});

  GetFollowModelRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    officeAddress = json['office_address'];
    officeName = json['office_name'];
    bio = json['bio'];
    dayOffs = json['day_offs'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['office_address'] = officeAddress;
    data['office_name'] = officeName;
    data['bio'] = bio;
    data['day_offs'] = dayOffs;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['photo_url'] = photoUrl;
    return data;
  }
}
