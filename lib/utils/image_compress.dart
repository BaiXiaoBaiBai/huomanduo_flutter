
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ImageCompress {
//
//
//   // 图片压缩 File -> Uint8List
//   Future<Uint8List?> testCompressFile(File file) async {
//     var result = await FlutterImageCompress.compressWithFile(
//       file.absolute.path,
//       minWidth: 2300,
//       minHeight: 1500,
//       quality: 94,
//       rotate: 90,
//     );
//     print(file.lengthSync());
//     print(result?.length);
//     return result;
//   }
//
//   // 图片压缩 File -> File
//   Future<File> testCompressAndGetFile(File file) async {
//     if (file.lengthSync() < 200 * 1024) {
//       return file;
//     }
//     var quality = 100;
//     if (file.lengthSync() > 4 * 1024 * 1024) {
//       quality = 50;
//     } else if (file.lengthSync() > 2 * 1024 * 1024) {
//       quality = 60;
//     } else if (file.lengthSync() > 1 * 1024 * 1024) {
//       quality = 70;
//     } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
//       quality = 80;
//     } else if (file.lengthSync() > 0.25 * 1024 * 1024) {
//       quality = 90;
//     }
//
//     Directory dir = await getTemporaryDirectory();
//     //var dir = await path_provider.getTemporaryDirectory();
//     var targetPath = dir.absolute.path +"/"+DateTime.now().millisecondsSinceEpoch.toString()+ ".jpg";
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path, targetPath,
//       quality: 88,
//       rotate: 180,
//     );
//
//     print(file.lengthSync());
//     print(result!.lengthSync());
//
//     return result;
//   }
//
//   // Future<File?> testCompressAndGetFile(File file, String targetPath) async {
//   //   var targetPath = file.absolute.path +"/"+DateTime.now().millisecondsSinceEpoch.toString()+ ".png";
//   //   var result = await FlutterImageCompress.compressAndGetFile(
//   //     file.absolute.path, targetPath,
//   //     quality: 88,
//   //     rotate: 180,
//   //   );
//   //
//   //   print(file.lengthSync());
//   //   print(result?.lengthSync());
//   //
//   //   return result;
//   // }
//
//   // 图片压缩 Asset -> Uint8List
//   Future<Uint8List?> testCompressAsset(String assetName) async {
//     var list = await FlutterImageCompress.compressAssetImage(
//       assetName,
//       minHeight: 1920,
//       minWidth: 1080,
//       quality: 96,
//       rotate: 180,
//     );
//
//     return list;
//   }
//
//   // 图片压缩 Uint8List -> Uint8List
//   Future<Uint8List> testComporessList(Uint8List list) async {
//     var result = await FlutterImageCompress.compressWithList(
//       list,
//       minHeight: 1920,
//       minWidth: 1080,
//       quality: 96,
//       rotate: 135,
//     );
//     print(list.length);
//     print(result.length);
//     return result;
//   }
// }