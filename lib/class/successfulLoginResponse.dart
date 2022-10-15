class SuccessfulLoginResponse {
  String? message;
  Data? data;

  SuccessfulLoginResponse({this.message, this.data});

  SuccessfulLoginResponse.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccessToken'] = this.accessToken;
    return data;
  }
}
