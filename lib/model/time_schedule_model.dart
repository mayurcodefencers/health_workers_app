class TimeScheduleModel {
  String? success;
  String? status;
  String? message;
  List<Timeschedule>? timeschedule;

  TimeScheduleModel(
      {this.success, this.status, this.message, this.timeschedule});

  TimeScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['timeschedule'] != null) {
      timeschedule = <Timeschedule>[];
      json['timeschedule'].forEach((v) {
        timeschedule!.add(new Timeschedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.timeschedule != null) {
      data['timeschedule'] = this.timeschedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeschedule {
  String? id;
  String? morningShift;
  String? eveningShift;
  String? updatedDate;
  String? updatedBy;

  Timeschedule(
      {this.id,
        this.morningShift,
        this.eveningShift,
        this.updatedDate,
        this.updatedBy});

  Timeschedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    morningShift = json['morning_shift'];
    eveningShift = json['evening_shift'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['morning_shift'] = this.morningShift;
    data['evening_shift'] = this.eveningShift;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
