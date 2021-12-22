class LoanCreationModel {
  String loanId;
  String loanProductId;
  String borrowerId;
  String releaseDate;
  String appliedAmount;
  String latePaymentPenalties;
  String createdById;
  String branchID;
  String totalPayable;
  String duration;
  String firstPaymentDate;

  LoanCreationModel(
      {this.loanId,
      this.loanProductId,
      this.borrowerId,
      this.releaseDate,
      this.appliedAmount,
      this.latePaymentPenalties,
      this.branchID,
      this.totalPayable,
      this.duration,
      this.firstPaymentDate});

  LoanCreationModel.fromJson(Map<String, dynamic> json) {
    loanId = json['loan_id'];
    loanProductId = json['loan_product_id'];
    borrowerId = json['borrower_id'];
    releaseDate = json['release_date'];
    appliedAmount = json['applied_amount'];
    latePaymentPenalties = json['late_payment_penalties'];
    createdById = json["created_user_id"];
    branchID = json["branch_id"];
    branchID = json["total_payable"];
    duration = json["duration"];
    duration = json["first_payment_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_id'] = this.loanId;
    data['loan_product_id'] = this.loanProductId;
    data['borrower_id'] = this.borrowerId;
    data['release_date'] = this.releaseDate ?? DateTime.now().toIso8601String();
    data['applied_amount'] = this.appliedAmount;
    data['late_payment_penalties'] = this.latePaymentPenalties;
    data['created_user_id'] = this.createdById;
    data['branch_id'] = this.branchID;
    data['total_payable'] = this.totalPayable;
    data['duration'] = this.duration;
    data['first_payment_date'] = this.firstPaymentDate = "";
    return data;
  }
}
