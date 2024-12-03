
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class imagePickerService{
  static final ImagePicker _picker = ImagePicker();


  static Future<File?> pickImageFromGallery() async {
    // Pick an image from the gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path); // Return the selected image as a File
    } else {
      return null; // No image selected
    }
  }
 static Future<List<File>> pickMultipleImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      return images.map((image) => File(image.path)).toList();  // Convert XFile to File
    }
    return [];
  }
}
