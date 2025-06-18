class SeqDataModel4 {
  List<SeqData4Response>? response;

  SeqDataModel4({this.response});

  SeqDataModel4.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <SeqData4Response>[];
      json['response'].forEach((v) {
        response!.add(new SeqData4Response.fromJson(v));
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

class SeqData4Response {
  String? cORPORATEID;
  String? bRANCHNAME;
  int? bRANCHID;
  String? dOCID;
  String? cUSTID;
  int? aMOUNT;
  String? vALUEDATE;
  String? sTATUS;
  String? rECEIVEDDT;
  int? rECEIVEDBY;
  int? tRANSID;

  SeqData4Response(
      {this.cORPORATEID,
        this.bRANCHNAME,
        this.bRANCHID,
        this.dOCID,
        this.cUSTID,
        this.aMOUNT,
        this.vALUEDATE,
        this.sTATUS,
        this.rECEIVEDDT,
        this.rECEIVEDBY,
        this.tRANSID});

  SeqData4Response.fromJson(Map<String, dynamic> json) {
    cORPORATEID = json['CORPORATE_ID'];
    bRANCHNAME = json['BRANCH_NAME'];
    bRANCHID = json['BRANCH_ID'];
    dOCID = json['DOC_ID'];
    cUSTID = json['CUST_ID'];
    aMOUNT = json['AMOUNT'];
    vALUEDATE = json['VALUE_DATE'];
    sTATUS = json['STATUS'];
    rECEIVEDDT = json['RECEIVED_DT'];
    rECEIVEDBY = json['RECEIVED_BY'];
    tRANSID = json['TRANS_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['DOC_ID'] = this.dOCID;
    data['CUST_ID'] = this.cUSTID;
    data['AMOUNT'] = this.aMOUNT;
    data['VALUE_DATE'] = this.vALUEDATE;
    data['STATUS'] = this.sTATUS;
    data['RECEIVED_DT'] = this.rECEIVEDDT;
    data['RECEIVED_BY'] = this.rECEIVEDBY;
    data['TRANS_ID'] = this.tRANSID;
    return data;
  }
}
