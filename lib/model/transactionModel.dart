class TransactionModel {
  String? success;
  String? status;
  String? message;
  List<UpcomingMeetinglist>? upcomingMeetinglist;

  TransactionModel(
      {this.success, this.status, this.message, this.upcomingMeetinglist});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['upcoming meetinglist'] != null) {
      upcomingMeetinglist = <UpcomingMeetinglist>[];
      json['upcoming meetinglist'].forEach((v) {
        upcomingMeetinglist!.add(new UpcomingMeetinglist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.upcomingMeetinglist != null) {
      data['upcoming meetinglist'] =
          this.upcomingMeetinglist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingMeetinglist {
  String? id;
  String? appointmentId;
  String? hwId;
  String? drId;
  String? paymentType;
  String? amount;
  String? createdDate;
  String? doctorname;

  UpcomingMeetinglist(
      {this.id,
        this.appointmentId,
        this.hwId,
        this.drId,
        this.paymentType,
        this.amount,
        this.createdDate,
        this.doctorname});

  UpcomingMeetinglist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    hwId = json['hw_id'];
    drId = json['dr_id'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    createdDate = json['created_date'];
    doctorname = json['doctorname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['hw_id'] = this.hwId;
    data['dr_id'] = this.drId;
    data['payment_type'] = this.paymentType;
    data['amount'] = this.amount;
    data['created_date'] = this.createdDate;
    data['doctorname'] = this.doctorname;
    return data;
  }
}
