class NotificationResponse {
  bool status;
  List<NotificationData> data;
  int unread;

  NotificationResponse({this.status, this.data, this.unread});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<NotificationData>();
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
      });
    }
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['unread'] = this.unread;
    return data;
  }
}

class NotificationData {
  int id;
  String message;
  String branchId;
  String createdAt;
  String updatedAt;
  String status;
  String customerId;

  NotificationData(
      {this.id,
      this.message,
      this.branchId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.customerId});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    branchId = json['branch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['branch_id'] = this.branchId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['customer_id'] = this.customerId;
    return data;
  }
}
