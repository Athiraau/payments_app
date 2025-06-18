class EmpDetailModel {
  List<Response>? response;

  EmpDetailModel({this.response});

  EmpDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? eMPNAME;
  int? bRANCHID;
  int? dESIGNATIONID;
  int? dEPARTMENTID;
  int? pOSTID;

  Response(
      {this.eMPNAME,
        this.bRANCHID,
        this.dESIGNATIONID,
        this.dEPARTMENTID,
        this.pOSTID});

  Response.fromJson(Map<String, dynamic> json) {
    eMPNAME = json['EMP_NAME'];
    bRANCHID = json['BRANCH_ID'];
    dESIGNATIONID = json['DESIGNATION_ID'];
    dEPARTMENTID = json['DEPARTMENT_ID'];
    pOSTID = json['POST_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_NAME'] = this.eMPNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['DESIGNATION_ID'] = this.dESIGNATIONID;
    data['DEPARTMENT_ID'] = this.dEPARTMENTID;
    data['POST_ID'] = this.pOSTID;
    return data;
  }
}
