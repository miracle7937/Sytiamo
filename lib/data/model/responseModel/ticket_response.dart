class TicketResponse {
  bool status;
  Data data;

  TicketResponse({this.status, this.data});

  TicketResponse.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String subject;
  String status;
  String createdUserId;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.userId,
      this.subject,
      this.status,
      this.createdUserId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    subject = json['subject'];
    status = json['status'];
    createdUserId = json['created_user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['subject'] = this.subject;
    data['status'] = this.status;
    data['created_user_id'] = this.createdUserId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
