class PayStatusChkModel {
  List<Response>? response;

  PayStatusChkModel({this.response});

  PayStatusChkModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
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

class Response {
  String? rES;

  Response({this.rES});

  Response.fromJson(Map<String, dynamic> json) {
    rES = json['RES'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RES'] = this.rES;
    return data;
  }
}
