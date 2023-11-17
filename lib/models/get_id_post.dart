class GetByIdPostModel {
  GetByIdPostModelRes? res;
  bool? status;

  GetByIdPostModel({this.res, this.status});

  GetByIdPostModel.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? GetByIdPostModelRes.fromJson(json['res']) : null;
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

class GetByIdPostModelRes {
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

  GetByIdPostModelRes(
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

  GetByIdPostModelRes.fromJson(Map<String, dynamic> json) {
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
