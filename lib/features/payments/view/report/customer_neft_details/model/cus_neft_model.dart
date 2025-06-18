class CusNEFTModel {
  String? cUSTID;
  String? cUSTNAME;
  String? bANK;
  String? bENEFICIARYACCOUNT;
  String? iFSCCODE;
  String? bENEFICIARYBRANCH;
  String? vERIFYSTATUS;

  CusNEFTModel(
      {this.cUSTID,
      this.cUSTNAME,
      this.bANK,
      this.bENEFICIARYACCOUNT,
      this.iFSCCODE,
      this.bENEFICIARYBRANCH,
      this.vERIFYSTATUS});

  CusNEFTModel.fromJson(Map<String, dynamic> json) {
    cUSTID = json['CUST_ID'];
    cUSTNAME = json['CUST_NAME'];
    bANK = json['BANK'];
    bENEFICIARYACCOUNT = json['BENEFICIARY_ACCOUNT'];
    iFSCCODE = json['IFSC_CODE'];
    bENEFICIARYBRANCH = json['BENEFICIARY_BRANCH'];
    vERIFYSTATUS = json['VERIFY_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUST_ID'] = this.cUSTID;
    data['CUST_NAME'] = this.cUSTNAME;
    data['BANK'] = this.bANK;
    data['BENEFICIARY_ACCOUNT'] = this.bENEFICIARYACCOUNT;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['BENEFICIARY_BRANCH'] = this.bENEFICIARYBRANCH;
    data['VERIFY_STATUS'] = this.vERIFYSTATUS;
    return data;
  }
}
