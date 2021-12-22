class CustomerResponse {
  bool status;
  List<CustomerModel> data;

  CustomerResponse({this.status, this.data});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CustomerModel>();
      json['data'].forEach((v) {
        data.add(new CustomerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerModel {
  int id;
  String firstName;
  String middleName;
  String email;
  String phone;
  String bvn;
  String address;
  String shopAddress;
  String dob;
  String userType;
  var roleId;
  var branchId;
  String status;
  String gname;
  String gphone;
  String gaddress;
  String gname2;
  String gphone2;
  String gaddress2;
  String profilePicture;
  String emailVerifiedAt;
  String smsVerifiedAt;
  String apiToken;
  String provider;
  String providerId;
  String countryCode;
  String createdAt;
  String updatedAt;
  String accountNo;

  CustomerModel(
      {this.id,
      this.firstName,
      this.middleName,
      this.email,
      this.phone,
      this.bvn,
      this.address,
      this.shopAddress,
      this.dob,
      this.userType,
      this.roleId,
      this.branchId,
      this.status,
      this.gname,
      this.gphone,
      this.gaddress,
      this.gname2,
      this.gphone2,
      this.gaddress2,
      this.profilePicture,
      this.emailVerifiedAt,
      this.smsVerifiedAt,
      this.apiToken,
      this.provider,
      this.providerId,
      this.countryCode,
      this.createdAt,
      this.updatedAt,
      this.accountNo});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    phone = json['phone'];
    bvn = json['bvn'];
    address = json['address'];
    shopAddress = json['shop_address'];
    dob = json['dob'];
    userType = json['user_type'];
    roleId = json['role_id'];
    branchId = json['branch_id'];
    status = json['status'];
    gname = json['gname'];
    gphone = json['gphone'];
    gaddress = json['gaddress'];
    gname2 = json['gname2'];
    gphone2 = json['gphone2'];
    gaddress2 = json['gaddress2'];
    profilePicture = json['profile_picture'];
    emailVerifiedAt = json['email_verified_at'];
    smsVerifiedAt = json['sms_verified_at'];
    apiToken = json['api_token'];
    provider = json['provider'];
    providerId = json['provider_id'];
    countryCode = json['country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountNo = json['account_no'];
    middleName = json['middle_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.firstName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['bvn'] = this.bvn;
    data['address'] = this.address;
    data['shop_address'] = this.shopAddress;
    data['dob'] = this.dob;
    data['user_type'] = this.userType;
    data['role_id'] = this.roleId;
    data['branch_id'] = this.branchId;
    data['status'] = this.status;
    data['gname'] = this.gname;
    data['gphone'] = this.gphone;
    data['gaddress'] = this.gaddress;
    data['gname2'] = this.gname2;
    data['gphone2'] = this.gphone2;
    data['gaddress2'] = this.gaddress2;
    data['profile_picture'] = this.profilePicture;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['sms_verified_at'] = this.smsVerifiedAt;
    data['api_token'] = this.apiToken;
    data['provider'] = this.provider;
    data['provider_id'] = this.providerId;
    data['country_code'] = this.countryCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['account_no'] = this.accountNo;
    data['middle_name'] = this.middleName;
    return data;
  }
}
