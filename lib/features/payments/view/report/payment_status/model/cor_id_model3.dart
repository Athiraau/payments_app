
class CorIdResponse3 {
  String? uNIQUEREFNO;
  String? pAYDATE;
  String? tRAUTRNO;
  String? cHQNO;
  String? sTATUS;
  String? sTATUSDESC;
  String? bANKREFNO;
  String? aMOUNT;
  String? bENEFICIARYACCNO;
  String? tRADATE;
  int? tRANSID;
  String? bATCHNO;

  CorIdResponse3(
      {this.uNIQUEREFNO,
        this.pAYDATE,
        this.tRAUTRNO,
        this.cHQNO,
        this.sTATUS,
        this.sTATUSDESC,
        this.bANKREFNO,
        this.aMOUNT,
        this.bENEFICIARYACCNO,
        this.tRADATE,
        this.tRANSID,
        this.bATCHNO});

  CorIdResponse3.fromJson(Map<String, dynamic> json) {
    uNIQUEREFNO = json['UNIQUE_REF_NO'];
    pAYDATE = json['PAY_DATE'];
    tRAUTRNO = json['TRA_UTR_NO'];
    cHQNO = json['CHQ_NO'];
    sTATUS = json['STATUS'];
    sTATUSDESC = json['STATUS_DESC'];
    bANKREFNO = json['BANK_REF_NO'];
    aMOUNT = json['AMOUNT'];
    bENEFICIARYACCNO = json['BENEFICIARY_ACC_NO'];
    tRADATE = json['TRA_DATE'];
    tRANSID = json['TRANSID'];
    bATCHNO = json['BATCH_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UNIQUE_REF_NO'] = this.uNIQUEREFNO;
    data['PAY_DATE'] = this.pAYDATE;
    data['TRA_UTR_NO'] = this.tRAUTRNO;
    data['CHQ_NO'] = this.cHQNO;
    data['STATUS'] = this.sTATUS;
    data['STATUS_DESC'] = this.sTATUSDESC;
    data['BANK_REF_NO'] = this.bANKREFNO;
    data['AMOUNT'] = this.aMOUNT;
    data['BENEFICIARY_ACC_NO'] = this.bENEFICIARYACCNO;
    data['TRA_DATE'] = this.tRADATE;
    data['TRANSID'] = this.tRANSID;
    data['BATCH_NO'] = this.bATCHNO;
    return data;
  }
}
