import 'dart:core';

class OrderModel {
  final String orderId;
  final String userId;
  final List<String> orderedItemIds;
  final double totalPrice;
  final String status;
  final Map<String, dynamic> timestamp;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderedItemIds,
    required this.totalPrice,
    required this.status,
    required this.timestamp,
  });

  // Convert JSON data into OrderModel object
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      orderedItemIds: List<String>.from(json['orderedItemIds']),
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      timestamp: json['timestamp'],
    );
  }
}
