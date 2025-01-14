class PayStatusTableModel {
  List<Response>? response;

  PayStatusTableModel({this.response});

  PayStatusTableModel.fromJson(Map<String, dynamic> json) {
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
  String? mODDESCR;
  String? bRANCHNAME;
  int? bRANCHID;
  String? dOCID;
  String? cUSTID;
  int? aMOUNT;
  String? vALUEDATE;
  String? sENDDATE;
  String? sENDTRANSID;
  String? cORPORATEID;
  String? bATCHNO;
  String? cUSTNAME;
  String? bENEFICIARYACCOUNT;
  String? iFSCCODE;
  String? sEQNO;

  Response(
      {this.mODDESCR,
        this.bRANCHNAME,
        this.bRANCHID,
        this.dOCID,
        this.cUSTID,
        this.aMOUNT,
        this.vALUEDATE,
        this.sENDDATE,
        this.sENDTRANSID,
        this.cORPORATEID,
        this.bATCHNO,
        this.cUSTNAME,
        this.bENEFICIARYACCOUNT,
        this.iFSCCODE,
        this.sEQNO});

  Response.fromJson(Map<String, dynamic> json) {
    mODDESCR = json['MOD_DESCR'];
    bRANCHNAME = json['BRANCH_NAME'];
    bRANCHID = json['BRANCH_ID'];
    dOCID = json['DOC_ID'];
    cUSTID = json['CUST_ID'];
    aMOUNT = json['AMOUNT'];
    vALUEDATE = json['VALUE_DATE'];
    sENDDATE = json['SEND_DATE'];
    sENDTRANSID = json['SEND_TRANSID'];
    cORPORATEID = json['CORPORATE_ID'];
    bATCHNO = json['BATCH_NO'];
    cUSTNAME = json['CUST_NAME'];
    bENEFICIARYACCOUNT = json['BENEFICIARY_ACCOUNT'];
    iFSCCODE = json['IFSC_CODE'];
    sEQNO = json['SEQ_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MOD_DESCR'] = this.mODDESCR;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['DOC_ID'] = this.dOCID;
    data['CUST_ID'] = this.cUSTID;
    data['AMOUNT'] = this.aMOUNT;
    data['VALUE_DATE'] = this.vALUEDATE;
    data['SEND_DATE'] = this.sENDDATE;
    data['SEND_TRANSID'] = this.sENDTRANSID;
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['BATCH_NO'] = this.bATCHNO;
    data['CUST_NAME'] = this.cUSTNAME;
    data['BENEFICIARY_ACCOUNT'] = this.bENEFICIARYACCOUNT;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['SEQ_NO'] = this.sEQNO;
    return data;
  }
}
