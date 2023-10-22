class FollowModel {
  Res? res;
  bool? status;

  FollowModel({this.res, this.status});

  FollowModel.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
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

class Res {
  int? id;
  int? businessId;
  int? followerId;
  String? createdAt;

  Res({this.id, this.businessId, this.followerId, this.createdAt});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    followerId = json['follower_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['follower_id'] = followerId;
    data['created_at'] = createdAt;
    return data;
  }
}
