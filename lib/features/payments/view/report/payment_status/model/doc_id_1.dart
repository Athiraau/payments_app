class DocId1 {
  String? mODDESCR;
  String? bRANCHNAME;
  int? bRANCHID;
  String? dOCID;
  String? cUSTID;
  int? aMOUNT;
  String? vALUEDATE;
  String? sENDDATE;
  int? sENDTRANSID;
  String? cORPORATEID;
  String? bATCHNO;

  DocId1(
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
        this.bATCHNO});

  DocId1.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}