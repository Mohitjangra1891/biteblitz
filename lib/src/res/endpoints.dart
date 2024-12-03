
import 'base.dart';

class Endpoints {
  static const _base = BasePaths.baseUrl;
  static const login =  "${BasePaths.baseUrl}/restaurant/login";
  static const register =  "${BasePaths.baseUrl}/restaurant/register";
  static const verifyOtp =  "${BasePaths.baseUrl}/restaurant/verify";
  static const addPanCard =  "${BasePaths.baseUrl}/restaurant/pancard";
  static const addgst =  "${BasePaths.baseUrl}/restaurant/gst";
  static const addfssai =  "${BasePaths.baseUrl}/restaurant/fssai";


  static const getBanks =  "${BasePaths.baseUrl}/restaurant/backDetails";
  static const addBankDetails =  "${BasePaths.baseUrl}/restaurant/bankDetails";
  static const deleteBankAccount =  "${BasePaths.baseUrl}/restaurant/bankDetails";



  static const toggleLive =  "${BasePaths.baseUrl}/restaurant/live";



  static const changePassword =  "${BasePaths.baseUrl}/restaurant/updatePassword";
  static const deleteAccount =  "${BasePaths.baseUrl}/restaurant";
  static const addFeedback =  "${BasePaths.baseUrl}/feedback";
  static const contactUS =  "${BasePaths.baseUrl}/contact";

  ///menu
  static const addNewMenuItem =  "${BasePaths.baseUrl}/products";

}
