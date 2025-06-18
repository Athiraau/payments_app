class NewBranchModel {
  String? bRANCHOPTION;

  NewBranchModel({this.bRANCHOPTION});

  NewBranchModel.fromJson(Map<String, dynamic> json) {
    bRANCHOPTION = json['BRANCH_OPTION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BRANCH_OPTION'] = this.bRANCHOPTION;
    return data;
  }
}

