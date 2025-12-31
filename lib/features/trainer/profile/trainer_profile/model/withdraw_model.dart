class WithdrawModel {
  final String id;
  final String userId;
  final double amount;
  final String status;
  final String? transferId;
  final String? destinationId;
  final String? balanceTransactionId;
  final String? stripeAccountId;
  final String? note;
  final String? rejectedReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  WithdrawModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    this.transferId,
    this.destinationId,
    this.balanceTransactionId,
    this.stripeAccountId,
    this.note,
    this.rejectedReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.fromMillisecondsSinceEpoch(0);
      try {
        return DateTime.parse(v.toString()).toLocal();
      } catch (_) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
    }

    return WithdrawModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      amount: (json['amount'] is num)
          ? (json['amount'] as num).toDouble()
          : double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString() ?? '',
      transferId: json['transferId']?.toString(),
      destinationId: json['destinationId']?.toString(),
      balanceTransactionId: json['balanceTransactionId']?.toString(),
      stripeAccountId: json['stripeAccountId']?.toString(),
      note: json['note']?.toString(),
      rejectedReason: json['rejectedReason']?.toString(),
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'amount': amount,
    'status': status,
    'transferId': transferId,
    'destinationId': destinationId,
    'balanceTransactionId': balanceTransactionId,
    'stripeAccountId': stripeAccountId,
    'note': note,
    'rejectedReason': rejectedReason,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
