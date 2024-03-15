class WalletAmountModel {
  String? success;
  String? status;
  String? message;
  WalletAmount? walletAmount;

  WalletAmountModel(
      {this.success, this.status, this.message, this.walletAmount});

  WalletAmountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    walletAmount = json['wallet amount'] != null
        ? new WalletAmount.fromJson(json['wallet amount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.walletAmount != null) {
      data['wallet amount'] = this.walletAmount!.toJson();
    }
    return data;
  }
}

class WalletAmount {
  String? id;
  String? name;
  String? img;
  String? centerId;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? walletAmount;

  WalletAmount(
      {this.id,
        this.name,
        this.img,
        this.centerId,
        this.email,
        this.password,
        this.phone,
        this.address,
        this.walletAmount});

  WalletAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    centerId = json['center_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    walletAmount = json['wallet_amount'];
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
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
