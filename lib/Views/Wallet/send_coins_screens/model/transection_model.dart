import 'package:web3dart/web3dart.dart';

import 'enum.dart';

class TransactionModel {
  final String id; // Unique identifier for the transaction
  final String fromAddress; // Sender's address
  final String toAddress; // Receiver's address
  final EtherAmount amount; // Transaction amount
  final DateTime timestamp; // Transaction timestamp
  TransactionStatus status; // Transaction status

  TransactionModel({
    required this.id,
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
    required this.timestamp,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'amount': amount.getInEther.toString(),
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString(),
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      fromAddress: json['fromAddress'],
      toAddress: json['toAddress'],
      amount: EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(json['amount'])),
      timestamp: DateTime.parse(json['timestamp']),
      status: TransactionStatus.values.firstWhere((e) => e.toString() == json['status']),
    );
  }
}
