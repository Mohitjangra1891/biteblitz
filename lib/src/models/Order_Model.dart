// Enum to represent the status of the payment
import 'menuItem Model.dart';
enum OrderStatus {
  preparing,
  ready,
  pickedUp,
}
// Extension to provide a string representation for each enum value
extension OrderStatusExtension on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      default:
        return 'Preparing';
    }
  }
}
enum PaymentStatus { paid, unpaid }
extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.unpaid:
        return 'UnPaid';
      default:
        return 'UnPaid';
    }
  }
}

// Data model representing an order
class OrderModel {
  final String orderId;
  final String customerName;
  final List<OrderItem> items;
  final PaymentStatus paymentStatus;
  final OrderStatus? orderStatus;

  OrderModel({
    required this.orderId,
    required this.customerName,
    required this.items,
    required this.paymentStatus,
    this.orderStatus
  });

  // Calculating the total order price by summing up each item total
  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  // Formatted total price for display
  String get formattedTotalPrice => '₹${totalPrice.toStringAsFixed(2)}';

}

// Data model representing an order item
class OrderItem {
  final String name;
  final int quantity;
  final DietaryType dietaryType; // Enum for Veg, Non-Veg, or Egg
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.dietaryType,

    required this.price,
  });

  // Calculating the total price of the item based on quantity
  double get totalPrice => price * quantity;

  // Formatted price for display purposes
  String get formattedPrice => '₹${totalPrice.toStringAsFixed(2)}';
}

