class GetBookingCategory {
  List<BookingCategoryListUrlRes>? res;
  bool? status;

  GetBookingCategory({this.res, this.status});

  GetBookingCategory.fromJson(Map<String, dynamic> json) {
    if (json['res'] != null) {
      res = <BookingCategoryListUrlRes>[];
      json['res'].forEach((v) {
        res!.add(BookingCategoryListUrlRes.fromJson(v));
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

class BookingCategoryListUrlRes {
  int? id;
  int? businessId;
  String? name;
  String? description;
  int? duration;
  int? price;

  BookingCategoryListUrlRes(
      {this.id,
        this.businessId,
        this.name,
        this.description,
        this.duration,
        this.price});

  BookingCategoryListUrlRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['name'] = name;
    data['description'] = description;
    data['duration'] = duration;
    data['price'] = price;
    return data;
  }
}
