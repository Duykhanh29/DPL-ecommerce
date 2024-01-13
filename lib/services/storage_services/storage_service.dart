import 'dart:io';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';

class StorageService {
  /*
  - paths for users:
    + avatars/{$userID}/
    + reviews/{$userID}/images/
    + reviews/{$userID}/videos/

  - paths for seller (next)
    + products/{$productID}/videos
    + products/{$productID}/images
    + verifications/{$shopID}/
    + shopLogos/{$shopID}/
    
  - chats/{$chatID}/videos
  - chat/{$chatID}/images
   
  - admin
    + deliverServices/{$deliverServiceID}/
    + categories/{$categoryID}/
    + flashsales/{$flashSaleID}/
  */
  final storage = FirebaseStorage.instance;

  // post to storage
  Future<bool> uploadFile(
      {required String filePath,
      required String fileName,
      required String rootRef,
      String? secondRef,
      String? thirdRef}) async {
    File file = File(filePath);
    try {
      String basePath = rootRef;
      if (secondRef != null) {
        basePath = basePath + "/" + secondRef;
      }
      if (thirdRef != null) {
        basePath = basePath + "/" + thirdRef;
      }
      await storage.ref('$basePath/$fileName').putFile(file);
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  // download to display to user interface
  Future<String> downloadURL(
      {required String filePath,
      required String fileName,
      required String rootRef,
      String? secondRef,
      String? thirdRef}) async {
    String basePath = rootRef;
    if (secondRef != null) {
      basePath = basePath + "/" + secondRef;
    }
    if (thirdRef != null) {
      basePath = basePath + "/" + thirdRef;
    }
    print("fileName: $fileName, type: $basePath ");
    Reference ref = storage.ref('$basePath');
    final result = await ref.listAll();
    int count = result.items.length;
    print("How many: ${count}");
    String downloadURL =
        await storage.ref('$basePath/$fileName').getDownloadURL();
    return downloadURL;
  }

  // download file to local
  Future downloadFileToLocalDevice(String Url, String fileType) async {
    try {
// Tải xuống và lưu trữ hình ảnh
      final reference = storage.refFromURL(
          Url); // Determine the file's storage location on Firebase Storage
      final url = await reference.getDownloadURL();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${reference.name}';
      await Dio().download(url, path);
      if (fileType == "video") {
        await GallerySaver.saveVideo(path, toDcim: true).whenComplete(
          () {},
          // () => Get.snackbar("Success", "",
          //     snackPosition: SnackPosition.TOP,
          //     titleText: const Text("Download successfully"),
          //     backgroundColor: Colors.greenAccent),
        );
        ;
      } else if (fileType == "image") {
        await GallerySaver.saveImage(path, toDcim: true).whenComplete(
          // () => Get.snackbar("Success", "",
          //     snackPosition: SnackPosition.TOP,
          //     titleText: const Text("Download successfully"),
          //     backgroundColor: Colors.greenAccent),
          () {},
        );
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  // download image without refer to location
  Future<void> downloadAndSaveImage(
      String imageUrl, BuildContext context) async {
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/image.jpg');
    await file.writeAsBytes(response.bodyBytes);
    try {
      final galleryPath = await GallerySaver.saveImage(file.path);
      // Get.snackbar(
      //   "Success",
      //   "",
      //   snackPosition: SnackPosition.TOP,
      //   titleText: const Text("Download successfully"),
      //   backgroundColor: Colors.greenAccent,
      // );
      if (galleryPath != null) {
        print('Ảnh đã được lưu: $galleryPath');
        ToastHelper.showDialog(
            LangText(context: context).getLocal()!.download_successfully,
            gravity: ToastGravity.BOTTOM,
            duration: Toast.LENGTH_LONG);
      } else {
        print('Lỗi khi download ảnh');
        ToastHelper.showDialog(
            LangText(context: context).getLocal()!.failed_to_download,
            gravity: ToastGravity.BOTTOM,
            duration: Toast.LENGTH_LONG);
      }
    } catch (error) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.failed_to_download}: $error",
          gravity: ToastGravity.BOTTOM,
          duration: Toast.LENGTH_LONG);
      // Xử lý lỗi tại đây
      print("Error saving image: $error");
      // Get.snackbar(
      //   "Error",
      //   "Failed to save image",
      //   snackPosition: SnackPosition.TOP,
      //   titleText: const Text("Error"),
      //   backgroundColor: Colors.redAccent,
      // );
    }
    // final galleryPath = await GallerySaver.saveImage(file.path).whenComplete(
    //     () => Get.snackbar("Success", "",
    //         snackPosition: SnackPosition.TOP,
    //         titleText: const Text("Download successfully"),
    //         backgroundColor: Colors.greenAccent));
  }

// not need methods below

  Future<Uint8List> _downloadFile(String fileURL) async {
    var response = await http.get(Uri.parse(fileURL));
    return response.bodyBytes;
  }

  Future uploadFromURL(String fileURL, String id) async {
    // Tải tệp tin từ URL
    Uint8List fileData = await _downloadFile(fileURL);
    try {
      Reference ref = storage.ref().child('avatars/$id');
      UploadTask uploadTask = ref.putData(fileData);
      await uploadTask.whenComplete(() => print('File uploaded successfully'));
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  // Future<List<Reference>> downloaddAllImages() async {
  //   final ListResult list = await storage.ref('test/').listAll();
  //   List<Reference> listItems = list.items;
  //   // List<String> listURL = [];
  //   // for (var element in listItems) {
  //   //   String imageURL = await element.getDownloadURL();
  //   //   listURL.add(imageURL);
  //   // }
  //   return listItems;
  // }

  // Future downloadFileToLocal(String imageName) async {
  //   Reference ref = storage.ref('test/$imageName');
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/${ref.name}');
  //   await ref.writeToFile(file);
  // }

  // Future getVideo() async {
  //   final ListResult list = await storage.ref('/videosTest').listAll();
  //   List<Reference> listItems = list.items;
  //   return listItems;
  // }

  //pdf
  Future uploadFilePDF(String fileName, String filePath) async {
    try {
      Reference ref = storage.ref().child('files/pdf/${fileName}');
      File file = File(filePath);
      UploadTask uploadTask = ref.putFile(file);
      await uploadTask.whenComplete(() => print('File uploaded successfully'));
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  // pdf
  Future loadPDFFromFirebase(String fileName) async {
    try {
      final refPDF = storage.ref().child('files/pdf/${fileName}');
      final bytes = await refPDF.getData();
      return storeFile(fileName, bytes);
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  //pdf
  Future storeFile(String fileName, Uint8List? bytes) async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName}');
    await file.writeAsBytes(bytes!, flush: true);
    return file;
  }
}
