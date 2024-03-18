class CompleteMeetingModel {
  String? success;
  String? status;
  String? message;
  List<CompleteMeetinglist>? completeMeetinglist;

  CompleteMeetingModel(
      {this.success, this.status, this.message, this.completeMeetinglist});

  CompleteMeetingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['complete meetinglist'] != null) {
      completeMeetinglist = <CompleteMeetinglist>[];
      json['complete meetinglist'].forEach((v) {
        completeMeetinglist!.add(new CompleteMeetinglist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.completeMeetinglist != null) {
      data['complete meetinglist'] =
          this.completeMeetinglist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompleteMeetinglist {
  String? id;
  String? userId;
  String? doctor;
  String? department;
  String? uploadFile;
  String? docUploadfile;
  String? date;
  String? timeShift;
  String? totalAmount;
  String? tokenNo;
  String? completeStatus;
  String? rescheduleStatus;
  String? missedStatus;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  String? userid;
  String? username;
  String? useremail;
  String? userphoneno;
  String? userage;
  String? gender;
  String? address;
  String? doctorname;
  String? doctorprofile;
  String? departmentname;

  CompleteMeetinglist(
      {this.id,
        this.userId,
        this.doctor,
        this.department,
        this.uploadFile,
        this.docUploadfile,
        this.date,
        this.timeShift,
        this.totalAmount,
        this.tokenNo,
        this.completeStatus,
        this.rescheduleStatus,
        this.missedStatus,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.userid,
        this.username,
        this.useremail,
        this.userphoneno,
        this.userage,
        this.gender,
        this.address,
        this.doctorname,
        this.doctorprofile,
        this.departmentname});

  CompleteMeetinglist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    doctor = json['doctor'];
    department = json['department'];
    uploadFile = json['upload_file'];
    docUploadfile = json['doc_uploadfile'];
    date = json['date'];
    timeShift = json['time_shift'];
    totalAmount = json['total_amount'];
    tokenNo = json['token_no'];
    completeStatus = json['complete_status'];
    rescheduleStatus = json['reschedule_status'];
    missedStatus = json['missed_status'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
    userid = json['userid'];
    username = json['username'];
    useremail = json['useremail'];
    userphoneno = json['userphoneno'];
    userage = json['userage'];
    gender = json['gender'];
    address = json['address'];
    doctorname = json['doctorname'];
    doctorprofile = json['doctorprofile'];
    departmentname = json['departmentname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['doctor'] = this.doctor;
    data['department'] = this.department;
    data['upload_file'] = this.uploadFile;
    data['doc_uploadfile'] = this.docUploadfile;
    data['date'] = this.date;
    data['time_shift'] = this.timeShift;
    data['total_amount'] = this.totalAmount;
    data['token_no'] = this.tokenNo;
    data['complete_status'] = this.completeStatus;
    data['reschedule_status'] = this.rescheduleStatus;
    data['missed_status'] = this.missedStatus;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userphoneno'] = this.userphoneno;
    data['userage'] = this.userage;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['doctorname'] = this.doctorname;
    data['doctorprofile'] = this.doctorprofile;
    data['departmentname'] = this.departmentname;
    return data;
  }
}
