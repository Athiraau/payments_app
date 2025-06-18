class BranchModel {
  int? bRANCHID;
  String? bRANCHNAME;

  BranchModel({this.bRANCHID, this.bRANCHNAME});

  BranchModel.fromJson(Map<String, dynamic> json) {
    bRANCHID = json['BRANCH_ID'];
    bRANCHNAME = json['BRANCH_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BRANCH_ID'] = this.bRANCHID;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    return data;
  }
}
