class MeUser {
  MeRes? res;
  bool? status;

  MeUser({this.res, this.status});

  MeUser.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? MeRes.fromJson(json['res']) : MeRes(
        fistName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        address: '',
        photoUrl: '',
        business: Business(
            id: 0,
            userId: 0,
            workCategoryId: 0,
            officeAddress: '',
            officeName: '',
            experience: 0,
            bio: '',
            dayOffs: ''));
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    }else{
      data['res'] = MeRes(
          fistName: '',
          lastName: '',
          userName: '',
          phoneNumber: '',
          address: '',
          photoUrl: '',
          business: Business(
              id: 0,
              userId: 0,
              workCategoryId: 0,
              officeAddress: '',
              officeName: '',
              experience: 0,
              bio: '',
              dayOffs: '')).toJson();
    }
    data['status'] = status ?? false;
    return data;
  }
}

class MeRes {
  int? id;
  String? fistName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? address;
  String? photoUrl;
  Business? business;

  MeRes(
      {this.id,
        this.fistName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.address,
        this.photoUrl,
        this.business});

  MeRes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fistName = json['fist_name'] ?? '';
    lastName = json['last_name'] ?? '';
    userName = json['user_name'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    address = json['address'] ?? '';
    photoUrl = json['photo_url'] ?? '';
    business = json['business'] != null
        ? Business.fromJson(json['business'])
        : Business(
        id: 0,
        userId: 0,
        workCategoryId: 0,
        officeAddress: '',
        officeName: '',
        experience: 0,
        bio: '',
        dayOffs: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['fist_name'] = fistName ?? '';
    data['last_name'] = lastName ?? '';
    data['user_name'] = userName ?? '';
    data['phone_number'] = phoneNumber ?? '';
    data['address'] = address ?? '';
    data['photo_url'] = photoUrl ?? '';
    if (business != null) {
      data['business'] = business!.toJson();
    }else{
      data['business'] = Business(
          id: 0,
          userId: 0,
          workCategoryId: 0,
          officeAddress: '',
          officeName: '',
          experience: 0,
          bio: '',
          dayOffs: '').toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  int? userId;
  int? workCategoryId;
  String? officeAddress;
  String? officeName;
  int? experience;
  String? bio;
  String? dayOffs;

  Business(
      {this.id,
        this.userId,
        this.workCategoryId,
        this.officeAddress,
        this.officeName,
        this.experience,
        this.bio,
        this.dayOffs});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    workCategoryId = json['work_category_id'] ?? 0;
    officeAddress = json['office_address'] ?? '';
    officeName = json['office_name'] ?? '';
    experience = json['experience'] ?? 0;
    bio = json['bio'] ?? '';
    dayOffs = json['day_offs'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['user_id'] = userId ?? 0;
    data['work_category_id'] = workCategoryId ?? 0;
    data['office_address'] = officeAddress ?? '';
    data['office_name'] = officeName ?? '';
    data['experience'] = experience ?? 0;
    data['bio'] = bio ?? '';
    data['day_offs'] = dayOffs ?? '';
    return data;
  }
}