import 'package:biteblitz/src/models/bankData.dart';
import 'package:biteblitz/src/models/menuItem%20Model.dart';
import 'package:biteblitz/src/res/imges.dart';

import '../models/Order_Model.dart';

class AppStrings {
  static const appName = "BiteBlitz Restaurant";
}

const restaurant_Name = 'Delicious Delights';
const restaurant_Owner_Name = 'Rahul Sharma';
const restaurant_Email = 'info@deliciousdelights.com';
const restaurant_Mobile = '+91 1234567890';
const restaurant_address = '123, Main Street, Mumbai, Maharashtra, 400001';

// // Placeholder data -
// final restaurant_info = [
//   {
//     "title": "Owner/Manager Name",
//     "subtitle": restaurant_Owner_Name,
//   },
//   {
//     "title": "Address",
//     "subtitle": restaurant_address,
//   },
//   {
//     "title": "Email Address",
//     "subtitle": restaurant_Email,
//   },
//   {
//     "title": "Phone",
//     "subtitle": restaurant_Mobile,
//   },
// ];

// Placeholder data -
final restaurant_info = [
  {
    "title": "Owner/Manager Name",
    "subtitle": "",
  },
  {
    "title": "Address",
    "subtitle": "",
  },
  {
    "title": "Email Address",
    "subtitle": "",
  },
  {
    "title": "Phone",
    "subtitle": "",
  },
];

// Creating order items
OrderItem item1 = OrderItem(name: 'Spicy Chicken Pizza', quantity: 2, price: 75.0, dietaryType: DietaryType.nonVeg);
OrderItem item2 = OrderItem(name: 'Veg Biryani', quantity: 1, price: 110.0, dietaryType: DietaryType.veg);

final List<OrderModel> ordersList = [
  OrderModel(
    orderId: '#1234',
    customerName: 'Raj Singh',
    items: [item1],
    paymentStatus: PaymentStatus.paid,
  ),
  OrderModel(
    orderId: '#5678',
    customerName: 'Kamal Hassan',
    items: [item1, item2],
    paymentStatus: PaymentStatus.unpaid,
  )
];

final List<MenuItemModel> recommendedItems = [
  MenuItemModel(
    imageUrl: AppImages.pizza,
    name: 'Pizza Margherita',
    description: 'A classic Italian pizza topped with tomato sauce, fresh mozzarella cheese, and basil leaves.',
    category: 'Pizzas',
    dietaryType: DietaryType.veg,
    pricingDetails: PricingDetails(
      price: 300.0,
      gstPercentage: 18.0,
      cgstPercentage: 9.0,
      sgstPercentage: 9.0,
      otherCharges: 20.0,
    ),
  ),
];

final List<MenuItemModel> pizzas = [
  MenuItemModel(
    imageUrl: AppImages.pizza,
    name: 'Pizza Margherita',
    description: 'A classic Italian pizza topped with tomato sauce, fresh mozzarella cheese, and basil leaves.',
    category: 'Pizzas',
    dietaryType: DietaryType.veg,
    pricingDetails: PricingDetails(
      price: 311.0,
      gstPercentage: 18.0,
      cgstPercentage: 9.0,
      sgstPercentage: 5.0,
      otherCharges: 20.0,
    ),
  ),
  MenuItemModel(
    imageUrl: AppImages.pizza,
    name: 'Veggie Supreme Pizza',
    description: 'A classic Italian pizza topped with tomato sauce, fresh mozzarella cheese, and basil leaves.',
    category: 'Pizzas',
    dietaryType: DietaryType.veg,
    pricingDetails: PricingDetails(
      price: 423.0,
      gstPercentage: 18.0,
      cgstPercentage: 9.0,
      sgstPercentage: 11.0,
      otherCharges: 30.0,
    ),
  ),
];

final List<MenuItemModel> sides = [
  MenuItemModel(
    imageUrl: AppImages.pizza,
    name: 'Coca-Cola (500ml)',
    description: ' Coca-Cola Coca-Cola Coca-ColaCoca-ColaCoca-Cola Coca-Cola Coca-Cola ',
    category: 'Sides',
    dietaryType: DietaryType.veg,
    pricingDetails: PricingDetails(
      price: 50.0,
      gstPercentage: 12.0,
      cgstPercentage: 9.0,
      sgstPercentage: 11.0,
      otherCharges: 10.0,
    ),
  ),
];

const insights_des =
    'Explore detailed insights about your restaurant\'sperformance, popular dishes, revenue trends, and customer feedback.';
const growth_des =
    'Track the growth of your restaurant over time, including key metrics such as total orders, revenue growth, and customer acquisition.';
const customer_feedback_des =
    'Understand your customers\' sentiments and improve your service quality with feedback analysis';

const tota_orders = '245';
const tota_revenue = '₹50,000';
const average_order = '₹204.08';
const average_daily_revenuw = '₹7,143';
const peak_hours = '7:00 PM-9:00 PM';

// final String bank_name = "State Bank of India-XXXX";

class FailureMessage {
  static const getRequestMessage = "GET REQUEST FAILED";
  static const postRequestMessage = "POST REQUEST FAILED";
  static const putRequestMessage = "PUT REQUEST FAILED";
  static const deleteRequestMessage = "DELETE REQUEST FAILED";

  static const jsonParsingFailed = "FAILED TO PARSE JSON RESPONSE";

  static const authTokenEmpty = "AUTH TOKEN EMPTY";

  static const failedToParseJson = "Failed to Parse JSON Data";
}

class SnackBarMessages {
  static const productLoadSuccess = "Products Loaded Successfully";
  static const productLoadFailed = "Failed To Load Products";
}

class LogLabel {
  static const product = "PRODUCT";
  static const auth = "AUTH";
  static const httpGet = "HTTP/GET";
  static const httpPost = "HTTP/POST";
  static const httpPut = "HTTP/PUT";
  static const httpDelete = "HTTP/DELETE";
}
