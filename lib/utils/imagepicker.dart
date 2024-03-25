import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<List<String>> uploadImage() async {
  final ImagePicker picker = ImagePicker();
  final images = await picker.pickMultiImage();
  if (images.isNotEmpty) {
    return images.map((e) => e.path).toList();
  } else {
    return [];
  }
}

class ImageServices {
  Future<String> uploadImageToFirebase({
    required String imagePath,
    required String productName,
  }) async {
    String fileName = imagePath.split('/').last;
    String folderName = 'product images';

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(productName)
        .child(fileName);

    try {
      await ref.putFile(File(imagePath));
    } catch (error) {
      return error.toString();
    }
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  Future<List<String>> uploadImages(
      {required List<String> imagePaths, required String productName}) async {
    List<String> imageUrls = [];
    for (String element in imagePaths) {
      final imageUrl = await uploadImageToFirebase(
          imagePath: element, productName: productName);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }
}
