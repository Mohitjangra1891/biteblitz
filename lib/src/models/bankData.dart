enum BankType {
  savings,
  current,
  salary,
}

// Extension to provide a string representation for each enum value
extension BankTypeExtension on BankType {
  String get value {
    switch (this) {
      case BankType.savings:
        return 'savings';
      case BankType.current:
        return 'current';
      case BankType.salary:
        return 'salary';
      default:
        return 'savings';
    }
  }
}

class BankDataModel {
  final String id;
  final String bankName;
  final int accNumber;
  final String ifsc;
  final String restaurantId;
  final bool? isdefault;

  final BankType? bankType;

  BankDataModel({
    required this.id,
    required this.bankName,
    required this.accNumber,
    required this.ifsc,
    required this.restaurantId,
    this.isdefault = false,
    this.bankType,
  });

  // Factory method to create a BankAccount from JSON
  factory BankDataModel.fromJson(Map<String, dynamic> json) {
    return BankDataModel(
      id: json['_id'],
      bankName: json['bankName'],
      accNumber: json['accountNumber'],
      ifsc: json['ifscCode'],
      restaurantId: json['restaurantId'],
    );
  }
}
