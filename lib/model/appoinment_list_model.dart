class AppointmentListModel {
  String? success;
  String? status;
  String? message;
  List<Appointmentlist>? appointmentlist;

  AppointmentListModel(
      {this.success, this.status, this.message, this.appointmentlist});

  AppointmentListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['appointmentlist'] != null) {
      appointmentlist = <Appointmentlist>[];
      json['appointmentlist'].forEach((v) {
        appointmentlist!.add(new Appointmentlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.appointmentlist != null) {
      data['appointmentlist'] =
          this.appointmentlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointmentlist {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? age;
  String? gender;
  String? address;
  String? createdDate;
  String? createdBy;

  Appointmentlist(
      {this.id,
        this.name,
        this.email,
        this.phoneNo,
        this.age,
        this.gender,
        this.address,
        this.createdDate,
        this.createdBy});

  Appointmentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    return data;
  }
}
