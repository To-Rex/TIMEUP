class Following {
  List<FollowingRes>? res;
  bool? status;

  Following({this.res, this.status});

  Following.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <FollowingRes>[];
      json['res'].forEach((v) {
        res!.add(FollowingRes.fromJson(v));
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

class FollowingRes {
  int? id;
  String? categoryName;
  String? officeAddress;
  String? officeName;
  String? bio;
  String? dayOffs;
  int? userId;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? photoUrl;

  FollowingRes({this.id, this.categoryName, this.officeAddress, this.officeName, this.bio, this.dayOffs, this.userId, this.fistName, this.lastName, this.userName, this.phoneNumber, this.photoUrl});

  FollowingRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    officeAddress = json['office_address'];
    officeName = json['office_name'];
    bio = json['bio'];
    dayOffs = json['day_offs'];
    userId = json['user_id'];
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
    data['user_id'] = userId;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['photo_url'] = photoUrl;
    return data;
  }
}
