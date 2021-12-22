class LoanCreationResponse {
  bool status;
  dynamic data;

  LoanCreationResponse({this.status, this.data});
  LoanCreationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? checkType(json['data']) : null;
  }
  checkType(value) {
    if (value is String) {
      return value;
    } else {
      return new Data.fromJson(value);
    }
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
  String loanId;
  String loanProductId;
  String borrowerId;
  String currencyId;
  String firstPaymentDate;
  String releaseDate;
  String appliedAmount;
  String latePaymentPenalties;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.loanId,
      this.loanProductId,
      this.borrowerId,
      this.currencyId,
      this.firstPaymentDate,
      this.releaseDate,
      this.appliedAmount,
      this.latePaymentPenalties,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    loanId = json['loan_id'];
    loanProductId = json['loan_product_id'];
    borrowerId = json['borrower_id'];
    currencyId = json['currency_id'];
    firstPaymentDate = json['first_payment_date'];
    releaseDate = json['release_date'];
    appliedAmount = json['applied_amount'];
    latePaymentPenalties = json['late_payment_penalties'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_id'] = this.loanId;
    data['loan_product_id'] = this.loanProductId;
    data['borrower_id'] = this.borrowerId;
    data['currency_id'] = this.currencyId;
    data['first_payment_date'] = this.firstPaymentDate;
    data['release_date'] = this.releaseDate;
    data['applied_amount'] = this.appliedAmount;
    data['late_payment_penalties'] = this.latePaymentPenalties;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
