class BookingBusinessGetListCategory {
  Res? res;
  bool? status;

  BookingBusinessGetListCategory({this.res, this.status});

  BookingBusinessGetListCategory.fromJson(Map<String, dynamic> json) {
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
  List<BookingCategories>? bookingCategories;
  List<Bookings>? bookings;

  Res({this.bookingCategories, this.bookings});

  Res.fromJson(Map<String, dynamic> json) {
    if (json['booking_categories'] != null) {
      bookingCategories = <BookingCategories>[];
      json['booking_categories'].forEach((v) {
        bookingCategories!.add(BookingCategories.fromJson(v));
      });
    }
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingCategories != null) {
      data['booking_categories'] =
          bookingCategories!.map((v) => v.toJson()).toList();
    }
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingCategories {
  int? id;
  int? businessId;
  String? name;
  String? description;
  int? duration;
  int? price;

  BookingCategories(
      {this.id,
        this.businessId,
        this.name,
        this.description,
        this.duration,
        this.price});

  BookingCategories.fromJson(Map<String, dynamic> json) {
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

class Bookings {
  int? id;
  int? businessId;
  int? clientId;
  String? date;
  String? time;
  String? endDate;
  String? endTime;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? photoUrl;

  Bookings(
      {this.id,
        this.businessId,
        this.clientId,
        this.date,
        this.time,
        this.endDate,
        this.endTime,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.photoUrl});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    clientId = json['client_id'];
    date = json['date'];
    time = json['time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['client_id'] = clientId;
    data['date'] = date;
    data['time'] = time;
    data['end_date'] = endDate;
    data['end_time'] = endTime;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['photo_url'] = photoUrl;
    return data;
  }
}
