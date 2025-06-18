class Seq5 {
  String? mODDESCR;
  String? dOCID;
  String? cUSTID;
  int? aMOUNT;
  String? vALUEDATE;
  String? cORPORATEID;
  String? pAYBANK;
  String? rEINITIATEBANK;
  String? rEINITIATEDT;
  String? rEINITIATEDBY;

  Seq5(
      {this.mODDESCR,
        this.dOCID,
        this.cUSTID,
        this.aMOUNT,
        this.vALUEDATE,
        this.cORPORATEID,
        this.pAYBANK,
        this.rEINITIATEBANK,
        this.rEINITIATEDT,
        this.rEINITIATEDBY});

  Seq5.fromJson(Map<String, dynamic> json) {
    mODDESCR = json['MOD_DESCR'];
    dOCID = json['DOC_ID'];
    cUSTID = json['CUST_ID'];
    aMOUNT = json['AMOUNT'];
    vALUEDATE = json['VALUE_DATE'];
    cORPORATEID = json['CORPORATE_ID'];
    pAYBANK = json['PAY_BANK'];
    rEINITIATEBANK = json['REINITIATE_BANK'];
    rEINITIATEDT = json['REINITIATE_DT'];
    rEINITIATEDBY = json['REINITIATED_BY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MOD_DESCR'] = this.mODDESCR;
    data['DOC_ID'] = this.dOCID;
    data['CUST_ID'] = this.cUSTID;
    data['AMOUNT'] = this.aMOUNT;
    data['VALUE_DATE'] = this.vALUEDATE;
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['PAY_BANK'] = this.pAYBANK;
    data['REINITIATE_BANK'] = this.rEINITIATEBANK;
    data['REINITIATE_DT'] = this.rEINITIATEDT;
    data['REINITIATED_BY'] = this.rEINITIATEDBY;
    return data;
  }
}