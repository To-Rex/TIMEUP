class GetByCategory {
  List<ResGetByCategory>? res;
  bool? status;

  GetByCategory({this.res, this.status});

  GetByCategory.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <ResGetByCategory>[];
      json['res'].forEach((v) {
        res!.add(ResGetByCategory.fromJson(v));
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

class ResGetByCategory {
  int? businessId;
  int? userId;
  int? experience;
  String? fistName;
  String? lastName;
  String? photoUrl;
  bool? followed;

  ResGetByCategory(
      {this.businessId,
        this.userId,
        this.experience,
        this.fistName,
        this.lastName,
        this.photoUrl,
        this.followed
      });

  ResGetByCategory.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    userId = json['user_id'];
    experience = json['experience'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    photoUrl = json['photo_url'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_id'] = businessId;
    data['user_id'] = userId;
    data['experience'] = experience;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['photo_url'] = photoUrl;
    data['followed'] = followed;
    return data;
  }
}
