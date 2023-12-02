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
  int? followingCount;
  Business? business;

  MeRes(
      {this.id,
      this.fistName,
      this.lastName,
      this.userName,
      this.phoneNumber,
      this.address,
      this.photoUrl,
      this.followingCount,
      this.business});

  MeRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    photoUrl = json['photo_url'];
    followingCount = json['following_count'];
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
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
    data['following_count'] = followingCount;
    if (business != null) {
      data['business'] = business!.toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  int? userId;
  int? categoryId;
  String? categoryName;
  String? officeAddress;
  String? officeName;
  int? experience;
  String? bio;
  String? dayOffs;
  int? followersCount;
  int? postsCount;

  Business(
      {this.id,
      this.userId,
      this.categoryId,
      this.categoryName,
      this.officeAddress,
      this.officeName,
      this.experience,
      this.bio,
      this.dayOffs,
      this.followersCount,
      this.postsCount});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    officeAddress = json['office_address'];
    officeName = json['office_name'];
    experience = json['experience'];
    bio = json['bio'];
    dayOffs = json['day_offs'];
    followersCount = json['followers_count'];
    postsCount = json['posts_count'];
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
    data['followers_count'] = followersCount;
    data['posts_count'] = postsCount;
    return data;
  }
}
