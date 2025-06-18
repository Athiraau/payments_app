class ImpsInquiryModel {
  String? mODDESCR;
  String? branchName;
  String? branchId;
  String? docId;
  String? customerId;
  String? amount;
  String? valueDate;
  String? sendDate;
  String? sendTransactionId;
  String? coOperateId;
  String? batchNumber;
  String? customerName;
  String? beneficiaryAccount;
  String? iFSCCode;
  String? sEQNumber;

  ImpsInquiryModel(
      {this.mODDESCR,
        this.branchName,
        this.branchId,
        this.docId,
        this.customerId,
        this.amount,
        this.valueDate,
        this.sendDate,
        this.sendTransactionId,
        this.coOperateId,
        this.batchNumber,
        this.customerName,
        this.beneficiaryAccount,
        this.iFSCCode,
        this.sEQNumber});

  ImpsInquiryModel.fromJson(Map<String, dynamic> json) {
    mODDESCR = json['MOD DESCR'];
    branchName = json['Branch name'];
    branchId = json['Branch id'];
    docId = json['Doc Id'];
    customerId = json['Customer Id'];
    amount = json['Amount'];
    valueDate = json['Value date'];
    sendDate = json['Send date'];
    sendTransactionId = json['Send transaction Id'];
    coOperateId = json['Co-operate Id'];
    batchNumber = json['Batch Number'];
    customerName = json['Customer name'];
    beneficiaryAccount = json['Beneficiary account'];
    iFSCCode = json['IFSC Code'];
    sEQNumber = json['SEQ Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MOD DESCR'] = this.mODDESCR;
    data['Branch name'] = this.branchName;
    data['Branch id'] = this.branchId;
    data['Doc Id'] = this.docId;
    data['Customer Id'] = this.customerId;
    data['Amount'] = this.amount;
    data['Value date'] = this.valueDate;
    data['Send date'] = this.sendDate;
    data['Send transaction Id'] = this.sendTransactionId;
    data['Co-operate Id'] = this.coOperateId;
    data['Batch Number'] = this.batchNumber;
    data['Customer name'] = this.customerName;
    data['Beneficiary account'] = this.beneficiaryAccount;
    data['IFSC Code'] = this.iFSCCode;
    data['SEQ Number'] = this.sEQNumber;
    return data;
  }
}
