class DocIdModel {
  String? dOCINFO;

  DocIdModel({this.dOCINFO});

  DocIdModel.fromJson(Map<String, dynamic> json) {
    dOCINFO = json['DOC_INFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOC_INFO'] = this.dOCINFO;
    return data;
  }
}