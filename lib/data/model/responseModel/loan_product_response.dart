class LoanProduct {
  bool status;
  List<LoanModel> data;

  LoanProduct({this.status, this.data});

  LoanProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<LoanModel>();
      json['data'].forEach((v) {
        data.add(new LoanModel.fromJson(v));
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

class LoanModel {
  int id;
  String name;
  String minimumAmount;
  String maximumAmount;
  Null description;
  String interestRate;
  String interestType;
  String term;
  String termPeriod;
  String status;
  String createdAt;
  String updatedAt;

  LoanModel(
      {this.id,
      this.name,
      this.minimumAmount,
      this.maximumAmount,
      this.description,
      this.interestRate,
      this.interestType,
      this.term,
      this.termPeriod,
      this.status,
      this.createdAt,
      this.updatedAt});

  LoanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    description = json['description'];
    interestRate = json['interest_rate'];
    interestType = json['interest_type'];
    term = json['term'];
    termPeriod = json['term_period'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    data['description'] = this.description;
    data['interest_rate'] = this.interestRate;
    data['interest_type'] = this.interestType;
    data['term'] = this.term;
    data['term_period'] = this.termPeriod;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
