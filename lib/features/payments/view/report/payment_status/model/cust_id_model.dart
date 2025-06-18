class CustomerIDModel {
  List<CustIdResponse>? response;

  CustomerIDModel({this.response});

  CustomerIDModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <CustIdResponse>[];
      json['response'].forEach((v) {
        response!.add(new CustIdResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustIdResponse {
  String? iDPROOF;

  CustIdResponse({this.iDPROOF});

  CustIdResponse.fromJson(Map<String, dynamic> json) {
    iDPROOF = json['ID_PROOF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_PROOF'] = this.iDPROOF;
    return data;
  }
}
