class GetSubCategory {
  List<ResSubCategory>? res;
  bool? status;

  GetSubCategory({this.res, this.status});

  GetSubCategory.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <ResSubCategory>[];
      json['res'].forEach((v) {
        res!.add(ResSubCategory.fromJson(v));
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

class ResSubCategory {
  int? id;
  int? parentId;
  String? name;

  ResSubCategory({this.id, this.parentId, this.name});

  ResSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    return data;
  }
}
