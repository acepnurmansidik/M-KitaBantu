class BankModel {
  final String name;
  final String bankCode;

  const BankModel({required this.bankCode, required this.name});

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(name: json['name'], bankCode: json['bank_code']);
  }

  // Map<String, dynamic> toJSON() {
  //   return {
  //     "name": name,
  //     "bank_code": bankCode,
  //   };
  // }
}

class PostBankModel {
  final String bankName;
  final String bankCode;
  final String accountName;
  final String accountNumber;

  const PostBankModel({
    required this.bankName,
    required this.bankCode,
    required this.accountName,
    required this.accountNumber,
  });

  Map<String, dynamic> toJSON() {
    return {
      "bank_name": bankName,
      "bank_code": bankCode,
      "account_code": accountName,
      "account_number": accountNumber,
    };
  }
}
