class BookUserAppointmentModel {
  String? success;
  String? status;
  String? message;
  int? tokenNo;

  BookUserAppointmentModel(
      {this.success, this.status, this.message, this.tokenNo});

  BookUserAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    tokenNo = json['token No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    data['token No'] = this.tokenNo;
    return data;
  }
}
