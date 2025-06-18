class ChangeReqDataModel {
  int? bRANCHID;
  String? cUSTID;
  int? aMOUNT;
  String? cORPORATEID;
  String? dOCID;

  ChangeReqDataModel(
      {this.bRANCHID, this.cUSTID, this.aMOUNT, this.cORPORATEID, this.dOCID});

  ChangeReqDataModel.fromJson(Map<String, dynamic> json) {
    bRANCHID = json['BRANCH_ID'];
    cUSTID = json['CUST_ID'];
    aMOUNT = json['AMOUNT'];
    cORPORATEID = json['CORPORATE_ID'];
    dOCID = json['DOC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BRANCH_ID'] = this.bRANCHID;
    data['CUST_ID'] = this.cUSTID;
    data['AMOUNT'] = this.aMOUNT;
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['DOC_ID'] = this.dOCID;
    return data;
  }
}