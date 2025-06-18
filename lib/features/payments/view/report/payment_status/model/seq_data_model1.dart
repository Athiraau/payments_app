class SeqDataModel1 {
  List<SeqData1Response>? response;

  SeqDataModel1({this.response});

  SeqDataModel1.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <SeqData1Response>[];
      json['response'].forEach((v) {
        response!.add(new SeqData1Response.fromJson(v));
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

class SeqData1Response {
  String? cORPORATEID;
  String? tRADT;
  String? bANK;

  SeqData1Response({this.cORPORATEID, this.tRADT, this.bANK});

  SeqData1Response.fromJson(Map<String, dynamic> json) {
    cORPORATEID = json['CORPORATE_ID'];
    tRADT = json['TRA_DT'];
    bANK = json['BANK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['TRA_DT'] = this.tRADT;
    data['BANK'] = this.bANK;
    return data;
  }
}
