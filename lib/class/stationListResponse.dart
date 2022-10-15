class StationListResponse {
  String? message;
  Data? data;

  StationListResponse({this.message, this.data});

  StationListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Stations>? stations;

  Data({this.stations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  int? stationId;
  int? depotId;
  String? name;
  int? stationCode;
  String? mobileNumber;
  double? latitude;
  double? longitude;
  String? province;
  String? city;
  String? address;
  String? stationType;
  String? opensAt;
  String? closesAt;
  String? status;
  bool? isPlbOnboarded;
  bool? isPlcOnboarded;
  String? businessName;
  String? createdAt;

  Stations(
      {this.stationId,
        this.depotId,
        this.name,
        this.stationCode,
        this.mobileNumber,
        this.latitude,
        this.longitude,
        this.province,
        this.city,
        this.address,
        this.stationType,
        this.opensAt,
        this.closesAt,
        this.status,
        this.isPlbOnboarded,
        this.isPlcOnboarded,
        this.businessName,
        this.createdAt});

  Stations.fromJson(Map<String, dynamic> json) {
    stationId = json['stationId'];
    depotId = json['depotId'];
    name = json['name'];
    stationCode = json['stationCode'];
    mobileNumber = json['mobileNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    province = json['province'];
    city = json['city'];
    address = json['address'];
    stationType = json['stationType'];
    opensAt = json['opensAt'];
    closesAt = json['closesAt'];
    status = json['status'];
    isPlbOnboarded = json['isPlbOnboarded'];
    isPlcOnboarded = json['isPlcOnboarded'];
    businessName = json['businessName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationId'] = this.stationId;
    data['depotId'] = this.depotId;
    data['name'] = this.name;
    data['stationCode'] = this.stationCode;
    data['mobileNumber'] = this.mobileNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['province'] = this.province;
    data['city'] = this.city;
    data['address'] = this.address;
    data['stationType'] = this.stationType;
    data['opensAt'] = this.opensAt;
    data['closesAt'] = this.closesAt;
    data['status'] = this.status;
    data['isPlbOnboarded'] = this.isPlbOnboarded;
    data['isPlcOnboarded'] = this.isPlcOnboarded;
    data['businessName'] = this.businessName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
