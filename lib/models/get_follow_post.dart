class GetFollowPost {
  List<GetFollowPostRes>? res;
  bool? status;

  GetFollowPost({this.res, this.status});

  GetFollowPost.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <GetFollowPostRes>[];
      json['res'].forEach((v) {
        res!.add(GetFollowPostRes.fromJson(v));
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

class GetFollowPostRes {
  int? id;
  String? mediaType;
  String? photo;
  String? video;
  String? title;
  String? description;
  int? businessId;
  String? createdAt;
  String? posterPhotoUrl;
  String? posterName;

  GetFollowPostRes(
      {this.id,
        this.mediaType,
        this.photo,
        this.video,
        this.title,
        this.description,
        this.businessId,
        this.createdAt,
        this.posterPhotoUrl,
        this.posterName});

  GetFollowPostRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    photo = json['photo'];
    video = json['video'];
    title = json['title'];
    description = json['description'];
    businessId = json['business_id'];
    createdAt = json['created_at'];
    posterPhotoUrl = json['poster_photo_url'];
    posterName = json['poster_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['photo'] = photo;
    data['video'] = video;
    data['title'] = title;
    data['description'] = description;
    data['business_id'] = businessId;
    data['created_at'] = createdAt;
    data['poster_photo_url'] = posterPhotoUrl;
    data['poster_name'] = posterName;
    return data;
  }
}
