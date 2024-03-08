class LoginModel {
  String? success;
  String? status;
  String? message;
  Admindata? admindata;
  List<UserData>? userData;

  LoginModel(
      {this.success, this.status, this.message, this.admindata, this.userData});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    admindata = json['admindata'] != null
        ? new Admindata.fromJson(json['admindata'])
        : null;
    if (json['UserData'] != null) {
      userData = <UserData>[];
      json['UserData'].forEach((v) {
        userData!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.admindata != null) {
      data['admindata'] = this.admindata!.toJson();
    }
    if (this.userData != null) {
      data['UserData'] = this.userData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Admindata {
  String? id;
  String? name;
  String? email;
  String? password;

  Admindata({this.id, this.name, this.email, this.password});

  Admindata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class UserData {
  String? id;
  String? name;
  String? img;
  String? centerId;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? tokenVal;
  String? tokenUpdate;
  String? createdDate;
  String? addedBy;
  String? updatedDate;
  String? updatedBy;

  UserData(
      {this.id,
        this.name,
        this.img,
        this.centerId,
        this.email,
        this.password,
        this.phone,
        this.address,
        this.tokenVal,
        this.tokenUpdate,
        this.createdDate,
        this.addedBy,
        this.updatedDate,
        this.updatedBy});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    centerId = json['center_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    tokenVal = json['token_val'];
    tokenUpdate = json['token_update'];
    createdDate = json['created_date'];
    addedBy = json['added_by'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['center_id'] = this.centerId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['token_val'] = this.tokenVal;
    data['token_update'] = this.tokenUpdate;
    data['created_date'] = this.createdDate;
    data['added_by'] = this.addedBy;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
