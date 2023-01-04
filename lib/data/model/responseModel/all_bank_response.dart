class AllBanksResponse {
  bool status;
  Banks banks;

  AllBanksResponse({this.status, this.banks});

  AllBanksResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    banks = json['banks'] != null ? new Banks.fromJson(json['banks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.banks != null) {
      data['banks'] = this.banks.toJson();
    }
    return data;
  }
}

class Banks {
  String status;
  String message;
  List<BanksData> data;

  Banks({this.status, this.message, this.data});

  Banks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<BanksData>();
      json['data'].forEach((v) {
        data.add(new BanksData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BanksData {
  int id;
  String code;
  String name;

  BanksData({this.id, this.code, this.name});

  BanksData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
