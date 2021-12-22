class UserAuthResponse {
  Success success;
  User user;

  UserAuthResponse({this.success, this.user});

  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Success {
  Token token;

  Success({this.token});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    return data;
  }
}

class Token {
  String name;
  List<String> abilities;
  int tokenableId;
  String tokenableType;
  String updatedAt;
  String createdAt;
  int id;

  Token(
      {this.name,
      this.abilities,
      this.tokenableId,
      this.tokenableType,
      this.updatedAt,
      this.createdAt,
      this.id});

  Token.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abilities = json['abilities'].cast<String>();
    tokenableId = json['tokenable_id'];
    tokenableType = json['tokenable_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['abilities'] = this.abilities;
    data['tokenable_id'] = this.tokenableId;
    data['tokenable_type'] = this.tokenableType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class User {
  int id;
  String name;
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

  User(
      {this.id,
      this.name,
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    return data;
  }
}
