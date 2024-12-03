// Enum to represent dietary type
enum DietaryType {
  veg,
  nonVeg,
  egg,
}
extension DietaryTypeExtension on DietaryType {
  String get value {
    switch (this) {
      case DietaryType.veg:
        return 'Veg';
      case DietaryType.nonVeg:
        return 'Non-Veg';
      case DietaryType.egg:
        return 'Egg';
      default:
        return 'Veg';
    }
  }
}
// PizzaDetails.dart
class MenuItemModel {
  final String imageUrl;
  final String name;
  final String description;
  final PricingDetails pricingDetails;
  final String category; // Added category (e.g., Pizzas, Sides)
  final DietaryType dietaryType; // Enum for Veg, Non-Veg, or Egg

  MenuItemModel({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.pricingDetails,
    required this.category,
    required this.dietaryType,
  });
}

class PricingDetails {
  final double price;
  final double gstPercentage;
  final double cgstPercentage;
  final double sgstPercentage;
  final double otherCharges;
  final double total;

  PricingDetails({
    required this.price,
    required this.gstPercentage,
    required this.cgstPercentage,
    required this.sgstPercentage,
    required this.otherCharges,
  }) : total = _calculateTotal(
          price: price,
          gstPercentage: gstPercentage,
          cgstPercentage: cgstPercentage,
          sgstPercentage: sgstPercentage,
          otherCharges: otherCharges,
        );

  String get formattedPrice => '₹${price.toStringAsFixed(2)}';

  String get formatted_otherCharges => '₹${price.toStringAsFixed(2)}';

  String get formatted_CGST_Price {
    double amount = (price * cgstPercentage) / 100;
    return '₹${amount.toStringAsFixed(2)}';
  }

  String get formatted_SGST_Price {
    double amount = (price * sgstPercentage) / 100;
    return '₹${amount.toStringAsFixed(2)}';
  }

  // Calculate total including taxes and other charges
  static double _calculateTotal({
    required double price,
    required double gstPercentage,
    required double cgstPercentage,
    required double sgstPercentage,
    required double otherCharges,
  }) {
    double gst = (price * gstPercentage) / 100;
    double cgst = (price * cgstPercentage) / 100;
    double sgst = (price * sgstPercentage) / 100;
    return price + gst + cgst + sgst + otherCharges;
  }
}
