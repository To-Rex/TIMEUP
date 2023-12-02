class GetMePost {
  List<GetMePostRes>? res;
  bool? status;

  GetMePost({this.res, this.status});

  GetMePost.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <GetMePostRes>[];
      json['res'].forEach((v) {
        res!.add(GetMePostRes.fromJson(v));
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

class GetMePostRes {
  int? id;
  String? mediaType;
  String? photo;
  String? title;
  String? description;
  int? businessId;
  String? createdAt;

  GetMePostRes(
      {this.id,
      this.mediaType,
      this.photo,
      this.title,
      this.description,
      this.businessId,
      this.createdAt});

  GetMePostRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    photo = json['photo'];
    title = json['title'];
    description = json['description'];
    businessId = json['business_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['photo'] = photo;
    data['title'] = title;
    data['description'] = description;
    data['business_id'] = businessId;
    data['created_at'] = createdAt;
    return data;
  }
}
