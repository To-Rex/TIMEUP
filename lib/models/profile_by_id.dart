class ProfileById {
  ProfileByIdRes? res;
  bool? status;

  ProfileById({this.res, this.status});

  ProfileById.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? ProfileByIdRes.fromJson(json['res']) : null;
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

class ProfileByIdRes {
  int? id;
  int? userId;
  int? categoryId;
  String? categoryName;
  String? officeAddress;
  String? officeName;
  int? experience;
  String? bio;
  String? dayOffs;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;
  bool? followed;

  ProfileByIdRes(
      {this.id,
        this.userId,
        this.categoryId,
        this.categoryName,
        this.officeAddress,
        this.officeName,
        this.experience,
        this.bio,
        this.dayOffs,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl,
        this.followed
      });

  ProfileByIdRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    officeAddress = json['office_address'];
    officeName = json['office_name'];
    experience = json['experience'];
    bio = json['bio'];
    dayOffs = json['day_offs'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    photoUrl = json['photo_url'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['office_address'] = officeAddress;
    data['office_name'] = officeName;
    data['experience'] = experience;
    data['bio'] = bio;
    data['day_offs'] = dayOffs;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['photo_url'] = photoUrl;
    data['followed'] = followed;
    return data;
  }
}
