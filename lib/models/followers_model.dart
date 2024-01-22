class Followers {
  List<FollowersRes>? res;
  bool? status;

  Followers({this.res, this.status});

  Followers.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <FollowersRes>[];
      json['res'].forEach((v) {
        res!.add(FollowersRes.fromJson(v));
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

class FollowersRes {
  int? id;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;
  //"followed": true,
  //             "business_id": 2
  bool? followed;
  int? businessId;

  FollowersRes(
      {this.id,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl,
        this.followed,
        this.businessId
      });

  FollowersRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    photoUrl = json['photo_url'];
    followed = json['followed'];
    businessId = json['business_id'];
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
    data['followed'] = followed;
    data['business_id'] = businessId;
    return data;
  }
}
