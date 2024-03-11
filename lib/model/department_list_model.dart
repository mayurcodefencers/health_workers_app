class DepartmentListModel {
  String? success;
  String? status;
  String? message;
  List<Departmentlist>? departmentlist;

  DepartmentListModel(
      {this.success, this.status, this.message, this.departmentlist});

  DepartmentListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['departmentlist'] != null) {
      departmentlist = <Departmentlist>[];
      json['departmentlist'].forEach((v) {
        departmentlist!.add(new Departmentlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.departmentlist != null) {
      data['departmentlist'] =
          this.departmentlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departmentlist {
  String? id;
  String? department;
  String? createdDate;
  String? addedBy;
  String? updatedDate;
  String? updatedBy;

  Departmentlist(
      {this.id,
        this.department,
        this.createdDate,
        this.addedBy,
        this.updatedDate,
        this.updatedBy});

  Departmentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    department = json['department'];
    createdDate = json['created_date'];
    addedBy = json['added_by'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department'] = this.department;
    data['created_date'] = this.createdDate;
    data['added_by'] = this.addedBy;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
