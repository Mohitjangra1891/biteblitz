
import '../utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseProdUrl = "https://bitebitz-efchhjgfamebhsbd.centralindia-01.azurewebsites.net/api/v1";

  // static const baseProdUrl = "http://localhost:3000/api/v1";
  // static const baseTestUrl = "http://localhost:3000/api/v1";
  static const baseTestUrl = "https://bitebitz-efchhjgfamebhsbd.centralindia-01.azurewebsites.net/api/v1";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
