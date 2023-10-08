class GetRegion {
  List<String>? res;
  bool? status;

  GetRegion({this.res, this.status});

  GetRegion.fromJson(Map<String, dynamic> json) {
    res = json['res'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['res'] = res;
    data['status'] = status;
    return data;
  }
}
