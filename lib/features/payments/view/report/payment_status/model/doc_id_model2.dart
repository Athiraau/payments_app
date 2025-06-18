class DocIdModel2 {
  List<ResponseDocId2>? docId2response;

  DocIdModel2({this.docId2response});

  DocIdModel2.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      docId2response = <ResponseDocId2>[];
      json['response'].forEach((v) {
        docId2response!.add(new ResponseDocId2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docId2response != null) {
      data['response'] = this.docId2response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseDocId2 {
  String? cUSTNAME;
  String? bENEFICIARYACCOUNT;
  String? iFSCCODE;
  String? bANKNAME;
  String? sTATUS;
  String? cUSTID;

  ResponseDocId2(
      {this.cUSTNAME,
      this.bENEFICIARYACCOUNT,
      this.iFSCCODE,
      this.bANKNAME,
      this.sTATUS,
      this.cUSTID});

  ResponseDocId2.fromJson(Map<String, dynamic> json) {
    cUSTNAME = json['CUST_NAME'];
    bENEFICIARYACCOUNT = json['BENEFICIARY_ACCOUNT'];
    iFSCCODE = json['IFSC_CODE'];
    bANKNAME = json['BANKNAME'];
    sTATUS = json['STATUS'];
    cUSTID = json['CUST_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUST_NAME'] = this.cUSTNAME;
    data['BENEFICIARY_ACCOUNT'] = this.bENEFICIARYACCOUNT;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['BANKNAME'] = this.bANKNAME;
    data['STATUS'] = this.sTATUS;
    data['CUST_ID'] = this.cUSTID;
    return data;
  }
}
