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
  int? parent_id;
  String? name;

  ResSubCategory({this.id, this.name, this.parent_id});

  ResSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent_id = json['parent_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parent_id;
    data['name'] = name;
    return data;
  }
}
