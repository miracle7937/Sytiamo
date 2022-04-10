import 'dart:io';

class EnrollmentModel {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone;
  String bvn;
  String nin;
  String address;
  String shopAddress;
  String dob;
  String gender;
  String userType;
  String roleId;
  String branchId;
  String status;
  String gname;
  String gphone;
  String gaddress;
  String gname2;
  String gphone2;
  String gaddress2;
  String accountNo;
  File profilePicture;
  File gpicture;
  String houseBusStop;
  String shopBusStop;
  String guarantorBusStop1;
  String guarantorBusStop2;

  EnrollmentModel(
      {this.id,
      this.guarantorBusStop1,
      this.guarantorBusStop2,
      this.profilePicture,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phone,
      this.bvn,
      this.nin,
      this.address,
      this.shopAddress,
      this.dob,
      this.gender,
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
      this.accountNo,
      this.houseBusStop,
      this.shopBusStop});

  EnrollmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    bvn = json['bvn'];
    nin = json['nin'];
    address = json['address'];
    shopAddress = json['shop_address'];
    dob = json['dob'];
    gender = json['gender'];
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
    accountNo = json['account_no'];
    houseBusStop = json['hbus_stop'];
    shopBusStop = json['sbus_stop'];
    guarantorBusStop1 = json['gbus_stop'];
    guarantorBusStop2 = json['g2bus_stop'];
    profilePicture = json['profile_picture'];
    gpicture = json['gpicture'];
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
    data['shop_address'] = this.shopAddress;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
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
    data['account_no'] = this.accountNo;
    data['hbus_stop'] = this.houseBusStop;
    data['sbus_stop'] = this.shopBusStop;
    data['gbus_stop'] = this.guarantorBusStop1;
    data['g2bus_stop'] = this.guarantorBusStop2;
    data['profile_picture'] = this.profilePicture;
    data['gpicture'] = this.gpicture;
    return data;
  }
}
