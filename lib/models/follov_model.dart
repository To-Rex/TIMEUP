class FollowModel {
  FollowModelRes? res;
  bool? status;

  FollowModel({this.res, this.status});

  FollowModel.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? FollowModelRes.fromJson(json['res']) : null;
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

class FollowModelRes {
  int? id;
  int? businessId;
  int? followerId;
  String? createdAt;

  FollowModelRes({this.id, this.businessId, this.followerId, this.createdAt});

  FollowModelRes.fromJson(Map<String, dynamic> json) {
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
