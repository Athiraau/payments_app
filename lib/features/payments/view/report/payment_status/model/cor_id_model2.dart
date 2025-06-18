class CorIdResponse2 {
  String? tRANREFNO;
  String? tRADT;
  String? aCTCODE;
  String? rESPONSE;
  String? bANKRRN;
  String? bANKREFNUM;
  int? tRANSID;
  String? bANK;

  CorIdResponse2(
      {this.tRANREFNO,
        this.tRADT,
        this.aCTCODE,
        this.rESPONSE,
        this.bANKRRN,
        this.bANKREFNUM,
        this.tRANSID,
        this.bANK});

  CorIdResponse2.fromJson(Map<String, dynamic> json) {
    tRANREFNO = json['TRANREFNO'];
    tRADT = json['TRADT'];
    aCTCODE = json['ACTCODE'];
    rESPONSE = json['RESPONSE'];
    bANKRRN = json['BANKRRN'];
    bANKREFNUM = json['BANK_REF_NUM'];
    tRANSID = json['TRANS_ID'];
    bANK = json['BANK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRANREFNO'] = this.tRANREFNO;
    data['TRADT'] = this.tRADT;
    data['ACTCODE'] = this.aCTCODE;
    data['RESPONSE'] = this.rESPONSE;
    data['BANKRRN'] = this.bANKRRN;
    data['BANK_REF_NUM'] = this.bANKREFNUM;
    data['TRANS_ID'] = this.tRANSID;
    data['BANK'] = this.bANK;
    return data;
  }
}

