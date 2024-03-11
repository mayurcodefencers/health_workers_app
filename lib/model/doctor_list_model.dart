class DoctorListModel {
  String? success;
  String? status;
  String? message;
  List<Doctorlist>? doctorlist;

  DoctorListModel({this.success, this.status, this.message, this.doctorlist});

  DoctorListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['doctorlist'] != null) {
      doctorlist = <Doctorlist>[];
      json['doctorlist'].forEach((v) {
        doctorlist!.add(new Doctorlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.doctorlist != null) {
      data['doctorlist'] = this.doctorlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctorlist {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? image;
  String? departmentId;
  String? price;
  String? doctorType;
  String? createdDate;
  String? addedBy;
  String? updatedDate;
  String? updatedBy;

  Doctorlist(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.gender,
        this.image,
        this.departmentId,
        this.price,
        this.doctorType,
        this.createdDate,
        this.addedBy,
        this.updatedDate,
        this.updatedBy});

  Doctorlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    gender = json['gender'];
    image = json['image'];
    departmentId = json['department_id'];
    price = json['price'];
    doctorType = json['doctor_type'];
    createdDate = json['created_date'];
    addedBy = json['added_by'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['department_id'] = this.departmentId;
    data['price'] = this.price;
    data['doctor_type'] = this.doctorType;
    data['created_date'] = this.createdDate;
    data['added_by'] = this.addedBy;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
