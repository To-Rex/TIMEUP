class GetCategory {
  List<ResCategory>? res;
  bool? status;

  GetCategory({this.res, this.status});

  GetCategory.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <ResCategory>[];
      json['res'].forEach((v) {
        res!.add(ResCategory.fromJson(v));
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

class ResCategory {
  int? id;
  String? name;

  ResCategory({this.id, this.name});

  ResCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
