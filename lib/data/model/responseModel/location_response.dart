class LocationResponse {
  bool status;
  List<LocationModel> data;

  LocationResponse({this.status, this.data});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<LocationModel>();
      json['data'].forEach((v) {
        data.add(new LocationModel.fromJson(v));
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

class LocationModel {
  int id;
  String name;
  String contactEmail;
  String contactPhone;
  String address;
  String descriptions;
  String createdAt;
  String updatedAt;

  LocationModel(
      {this.id,
      this.name,
      this.contactEmail,
      this.contactPhone,
      this.address,
      this.descriptions,
      this.createdAt,
      this.updatedAt});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    address = json['address'];
    descriptions = json['descriptions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['address'] = this.address;
    data['descriptions'] = this.descriptions;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
