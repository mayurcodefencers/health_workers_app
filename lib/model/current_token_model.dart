class CurrentTokenModel {
  String? success;
  String? status;
  String? message;
  String? currenttoken;

  CurrentTokenModel(
      {this.success, this.status, this.message, this.currenttoken});

  CurrentTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    currenttoken = json['currenttoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    data['currenttoken'] = this.currenttoken;
    return data;
  }
}
