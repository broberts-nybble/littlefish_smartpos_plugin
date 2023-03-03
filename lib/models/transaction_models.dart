class Transaction {
  double? amount;

  String? reference, description, deviceType, merchantId;

  TransactionType? transactionType;

  TenderType? tenderType;

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "reference": reference,
        "description": description,
        "deviceType": deviceType,
        "merchantId": merchantId,
        "transactionType": transactionType.toString(),
        "tenderType": tenderType.toString()
      };
}

enum TransactionType {
  sale,
  reversal,
}

enum TenderType { credit }
