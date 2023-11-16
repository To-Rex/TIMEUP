class GetPost {
  List<GetPostRes>? res;
  bool? status;

  GetPost({this.res, this.status});

  GetPost.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <GetPostRes>[];
      json['res'].forEach((v) {
        res!.add(GetPostRes.fromJson(v));
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

class GetPostRes {
  int? id;
  String? mediaType;
  String? photo;
  String? title;
  String? description;
  int? businessId;
  String? createdAt;

  GetPostRes(
      {this.id,
        this.mediaType,
        this.photo,
        this.title,
        this.description,
        this.businessId,
        this.createdAt});

  GetPostRes.fromJson(Map<String, dynamic> json) {
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
