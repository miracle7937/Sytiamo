class BreakDownLoanModel {
  bool status;
  Data data;

  BreakDownLoanModel({this.status, this.data});

  BreakDownLoanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<SingleLoanData> loandetails;
  List<Repayment> repayment;

  Data({this.loandetails, this.repayment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['loandetails'] != null) {
      loandetails = new List<SingleLoanData>();
      json['loandetails'].forEach((v) {
        loandetails.add(new SingleLoanData.fromJson(v));
      });
    }
    if (json['repayment'] != null) {
      repayment = new List<Repayment>();
      json['repayment'].forEach((v) {
        repayment.add(new Repayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loandetails != null) {
      data['loandetails'] = this.loandetails.map((v) => v.toJson()).toList();
    }
    if (this.repayment != null) {
      data['repayment'] = this.repayment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleLoanData {
  int id;
  String loanId;
  String loanProductId;
  String borrowerId;
  String firstPaymentDate;
  String releaseDate;
  String duration;
  String currencyId;
  String appliedAmount;
  String totalPayable;
  String totalPaid;
  String latePaymentPenalties;
  String attachment;
  String branchId;
  String description;
  String remarks;
  String status;
  String approvedDate;
  String approvedUserId;
  String createdUserId;
  String createdAt;
  String updatedAt;
  BorrowerData borrower;

  SingleLoanData(
      {this.id,
      this.loanId,
      this.loanProductId,
      this.borrowerId,
      this.firstPaymentDate,
      this.releaseDate,
      this.duration,
      this.currencyId,
      this.appliedAmount,
      this.totalPayable,
      this.totalPaid,
      this.latePaymentPenalties,
      this.attachment,
      this.branchId,
      this.description,
      this.remarks,
      this.status,
      this.approvedDate,
      this.approvedUserId,
      this.createdUserId,
      this.createdAt,
      this.updatedAt,
      this.borrower});

  SingleLoanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loan_id'];
    loanProductId = json['loan_product_id'];
    borrowerId = json['borrower_id'];
    firstPaymentDate = json['first_payment_date'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    currencyId = json['currency_id'];
    appliedAmount = json['applied_amount'];
    totalPayable = json['total_payable'];
    totalPaid = json['total_paid'];
    latePaymentPenalties = json['late_payment_penalties'];
    attachment = json['attachment'];
    branchId = json['branch_id'];
    description = json['description'];
    remarks = json['remarks'];
    status = json['status'];
    approvedDate = json['approved_date'];
    approvedUserId = json['approved_user_id'];
    createdUserId = json['created_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    borrower = json['borrower'] != null
        ? new BorrowerData.fromJson(json['borrower'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_id'] = this.loanId;
    data['loan_product_id'] = this.loanProductId;
    data['borrower_id'] = this.borrowerId;
    data['first_payment_date'] = this.firstPaymentDate;
    data['release_date'] = this.releaseDate;
    data['duration'] = this.duration;
    data['currency_id'] = this.currencyId;
    data['applied_amount'] = this.appliedAmount;
    data['total_payable'] = this.totalPayable;
    data['total_paid'] = this.totalPaid;
    data['late_payment_penalties'] = this.latePaymentPenalties;
    data['attachment'] = this.attachment;
    data['branch_id'] = this.branchId;
    data['description'] = this.description;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['approved_date'] = this.approvedDate;
    data['approved_user_id'] = this.approvedUserId;
    data['created_user_id'] = this.createdUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.borrower != null) {
      data['borrower'] = this.borrower.toJson();
    }
    return data;
  }
}

class BorrowerData {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone;
  String bvn;
  String nin;
  String address;
  String hbusStop;
  String shopAddress;
  String sbusStop;
  String dob;
  String gender;
  String userType;
  String roleId;
  String branchId;
  String status;
  String gname;
  String gphone;
  String gaddress;
  String gbusStop;
  String gname2;
  String gphone2;
  String gaddress2;
  String g2busStop;
  String profilePicture;
  String gpicture;
  String emailVerifiedAt;
  String smsVerifiedAt;
  String apiToken;
  String provider;
  String providerId;
  String countryCode;
  String createdAt;
  String updatedAt;
  String accountNo;

  BorrowerData(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phone,
      this.bvn,
      this.nin,
      this.address,
      this.hbusStop,
      this.shopAddress,
      this.sbusStop,
      this.dob,
      this.gender,
      this.userType,
      this.roleId,
      this.branchId,
      this.status,
      this.gname,
      this.gphone,
      this.gaddress,
      this.gbusStop,
      this.gname2,
      this.gphone2,
      this.gaddress2,
      this.g2busStop,
      this.profilePicture,
      this.gpicture,
      this.emailVerifiedAt,
      this.smsVerifiedAt,
      this.apiToken,
      this.provider,
      this.providerId,
      this.countryCode,
      this.createdAt,
      this.updatedAt,
      this.accountNo});

  BorrowerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    bvn = json['bvn'];
    nin = json['nin'];
    address = json['address'];
    hbusStop = json['hbus_stop'];
    shopAddress = json['shop_address'];
    sbusStop = json['sbus_stop'];
    dob = json['dob'];
    gender = json['gender'];
    userType = json['user_type'];
    roleId = json['role_id'];
    branchId = json['branch_id'];
    status = json['status'];
    gname = json['gname'];
    gphone = json['gphone'];
    gaddress = json['gaddress'];
    gbusStop = json['gbus_stop'];
    gname2 = json['gname2'];
    gphone2 = json['gphone2'];
    gaddress2 = json['gaddress2'];
    g2busStop = json['g2bus_stop'];
    profilePicture = json['profile_picture'];
    gpicture = json['gpicture'];
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
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['bvn'] = this.bvn;
    data['nin'] = this.nin;
    data['address'] = this.address;
    data['hbus_stop'] = this.hbusStop;
    data['shop_address'] = this.shopAddress;
    data['sbus_stop'] = this.sbusStop;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['user_type'] = this.userType;
    data['role_id'] = this.roleId;
    data['branch_id'] = this.branchId;
    data['status'] = this.status;
    data['gname'] = this.gname;
    data['gphone'] = this.gphone;
    data['gaddress'] = this.gaddress;
    data['gbus_stop'] = this.gbusStop;
    data['gname2'] = this.gname2;
    data['gphone2'] = this.gphone2;
    data['gaddress2'] = this.gaddress2;
    data['g2bus_stop'] = this.g2busStop;
    data['profile_picture'] = this.profilePicture;
    data['gpicture'] = this.gpicture;
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

class Repayment {
  int id;
  String loanId;
  String branchId;
  String loanProductId;
  String borrowerId;
  String agentId;
  String totalPaid;
  String balance;
  String status;
  String createdAt;
  String updatedAt;

  Repayment(
      {this.id,
      this.loanId,
      this.branchId,
      this.loanProductId,
      this.borrowerId,
      this.agentId,
      this.totalPaid,
      this.balance,
      this.status,
      this.createdAt,
      this.updatedAt});

  Repayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loan_id'];
    branchId = json['branch_id'];
    loanProductId = json['loan_product_id'];
    borrowerId = json['borrower_id'];
    agentId = json['agent_id'];
    totalPaid = json['total_paid'];
    balance = json['balance'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_id'] = this.loanId;
    data['branch_id'] = this.branchId;
    data['loan_product_id'] = this.loanProductId;
    data['borrower_id'] = this.borrowerId;
    data['agent_id'] = this.agentId;
    data['total_paid'] = this.totalPaid;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
