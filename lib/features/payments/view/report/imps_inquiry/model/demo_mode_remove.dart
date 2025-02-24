class ImpsTableModel {
  final List<ImpsTableItem> items;

  ImpsTableModel({required this.items});

  factory ImpsTableModel.fromJsonList(List<Map<String, dynamic>> jsonList) {
    return ImpsTableModel(
      items: jsonList.map((item) => ImpsTableItem.fromJson(item)).toList(),
    );
  }

  @override
  String toString() {
    return items.map((item) => item.toString()).join('\n');
  }
}

class ImpsTableItem {
  final String? mODDESCR;
  final String? bRANCHNAME;
  final String? bRANCHID;
  final String? dOCID;
  final String? cUSTID;
  final String? aMOUNT;
  final String? vALUEDATE;
  final String? sENDDATE;
  final String? sENDTRANSID;
  final String? cORPORATEID;
  final String? bATCHNO;
  final String? cUSTNAME;
  final String? bENEFICIARYACCOUNT;
  final String? iFSCCODE;
  final String? sEQNO;

  ImpsTableItem({
    required this.mODDESCR,
    required this.bRANCHNAME,
    required this.bRANCHID,
    required this.dOCID,
    required this.cUSTID,
    required this.aMOUNT,
    required this.vALUEDATE,
    required this.sENDDATE,
    required this.sENDTRANSID,
    required this.cORPORATEID,
    required this.bATCHNO,
    required this.cUSTNAME,
    required this.bENEFICIARYACCOUNT,
    required this.iFSCCODE,
    required this.sEQNO,
  });

  factory ImpsTableItem.fromJson(Map<String, dynamic> json) {
    return ImpsTableItem(
      mODDESCR: json['MOD DESCR'],
      bRANCHNAME: json['Branch name'],
      bRANCHID: json['Branch id'],
      dOCID: json['Doc Id'],
      cUSTID: json['Customer Id'],
      aMOUNT: json['Amount'],
      vALUEDATE: json['Value date'],
      sENDDATE: json['Send date'],
      sENDTRANSID: json['Send transaction Id'],
      cORPORATEID: json['Co-operate Id'],
      bATCHNO: json['Batch Number'],
      cUSTNAME: json['Customer name'],
      bENEFICIARYACCOUNT: json['Beneficiary account'],
      iFSCCODE: json['IFSC Code'],
      sEQNO: json['SEQ Number'],
    );
  }

  @override
  String toString() {
    return '''
ImpsTableItem(
  mODDESCR: $mODDESCR,
  bRANCHNAME: $bRANCHNAME,
  bRANCHID: $bRANCHID,
  dOCID: $dOCID,
  cUSTID: $cUSTID,
  aMOUNT: $aMOUNT,
  vALUEDATE: $vALUEDATE,
  sENDDATE: $sENDDATE,
  sENDTRANSID: $sENDTRANSID,
  cORPORATEID: $cORPORATEID,
  bATCHNO: $bATCHNO,
  cUSTNAME: $cUSTNAME,
  bENEFICIARYACCOUNT: $bENEFICIARYACCOUNT,
  iFSCCODE: $iFSCCODE,
  sEQNO: $sEQNO
)''';
  }
}
