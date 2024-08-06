import 'dart:io';

import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/repository/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends GetxController {
  //TODO: Implement AdminController
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  final _storageRepository = StorageRepository();
  final _firestoreRepository = FirestoreRepository();

  final categoryName = ''.obs;
  final selectedImage = Rxn<File>();

  final listProduct = <Product>[].obs;

  final listCategories = [
    '3x3',
    'Rubik 3x3',
    'Rubik pyraminx',
    'others',
    'awkeoawkeowake'
  ];

  void changeCategory(String category) {
    categoryName.value = category;
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
      Get.back();
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      Get.back();
    }
  }

  Future<String?> uploadImage() async {
    try {
      final imageFile = selectedImage.value!;
      final taskSnapshot = await _storageRepository.sendProductImageToStorage(
          file: imageFile, productName: nameController.text);
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<void> addProduct() async {
    String? imageUrl;
    try {
      if (selectedImage.value != null) {
        imageUrl = await uploadImage();
      }
      final newProduct = Product(
        productName: nameController.text,
        productPrice: double.parse(priceController.text),
        productCategory: categoryName.value,
        productStock: int.parse(stockController.text),
        productImage: imageUrl,
      );
      final result = await _firestoreRepository.createProduct(newProduct);
      if (result) {
        Get.snackbar('Success', 'Product successfully added');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  Future<void> getProducts() async {
    listProduct.bindStream(_firestoreRepository.getListProduct());
    print(listProduct);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    selectedImage.close();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }
}
